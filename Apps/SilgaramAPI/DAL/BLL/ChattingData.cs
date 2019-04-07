using DAL.Models;

using DAL.Models.ViewModel;
using DAL.Resource;
using DAL.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static DAL.Enums.Enums;

namespace DAL.Bll
{
    public class ChattingData : IDisposable
    {
        SilgaramEntities db = new SilgaramEntities();
        bool IsLanguageEnglish = LanguageService.IsEn;
        DeleteService DeleteS = new DeleteService();
        UpdateService UpdateS = new UpdateService();
        CreateService CreateS = new CreateService();

        public object GetUserChatting(int skip, int take)
        {
            int UserId = AccessToken.GetUserId();
            User User = db.Users.Find(UserId);
            if (User == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.UserNotFound);

            List<UserChatVM> Chatting = new List<UserChatVM>();
            //Add Chating From My Ads
            Chatting.AddRange(db.Chattings.Where(c => c.Ad.FkUser_Id == UserId).ToList()
                .Select(c => new UserChatVM
                {
                    ChatId=c.Id,
                    AdId=c.FkAd_Id,
                    AdTitle = c.Ad.Title,
                    DateTimeCreateChat = DateService.GetDateTimeByCulture(c.Log.CreateDateTime),
                LastMessageInChatRoom= GetChatMessgeDetails(c.ChatMessages.Last()),
                }).ToList());

            //Add Chatting For Another Ads
            Chatting.AddRange(db.Chattings.Where(c => c.FkUser_Id == UserId).ToList()
                .Select(c=> new UserChatVM {
                    ChatId=c.Id,
                    AdId = c.FkAd_Id,

                    AdTitle = c.Ad.Title,
                DateTimeCreateChat=DateService.GetDateTimeByCulture(c.Log.CreateDateTime),
                LastMessageInChatRoom= GetChatMessgeDetails(c.ChatMessages.Last()),
            }).ToList());

            Chatting = Chatting.OrderByDescending(c => c.LastMessageInChatRoom.SendDateTime).Skip(skip).Take(take).ToList();

            if (Chatting.Count == 0)
                return new ResponseVM { RequestType = RequestTypeEnumVM.Info, Message = Token.NoDataMore };

            return new ResponseVM
            {
                RequestType = RequestTypeEnumVM.Success,
                IsData = true,
                Data = Chatting
            };
        }
        private object CheckCreateChat(int adId)
        {
            try
            {
                if (adId <= 0)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.FiledIsRequired + " " + Token.AdId);

                int UserId = AccessToken.GetUserId();

                //check ad not found
                var Ad = db.Ads.Find(adId);
                if (Ad == null)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.AdNotFound);

                if (Ad.FkUser_Id == UserId)
                    return new ResponseVM(RequestTypeEnumVM.Error, Token.YouCanNotCreateChatForYoureAds);


                var Chat = Ad.Chattings.SingleOrDefault(c => c.FkUser_Id == UserId);

                object DataReturn = new
                {
                    IsCreateInThePast = Chat != null,
                    Caht = Chat == null ?null:new
                    {
                        Chat.Id,
                        Chat.FkAd_Id,
                        CreateDateTime = DateService.GetDateTimeByCulture(Chat.Log.CreateDateTime),

                        AdTitle = Chat.Ad.Title,
                        CountChatMessage = Chat.ChatMessages.ToList(),
                        ChatMessages = GetChatMessgeDetails(Chat.ChatMessages.OrderByDescending(c => c.Id).Skip(0).Take(10).ToList())
                    }
                };
                return new ResponseVM { RequestType = RequestTypeEnumVM.Success, Message = Token.Success };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }

        private object CheckUserAllowAccessToChatRoom(int adId)
        {
            int UserId = AccessToken.GetUserId();
            return db.Chattings.Any(c=> c.FkAd_Id== adId && UserId != c.FkUser_Id && UserId != c.Ad.FkUser_Id);
        }

        /// <summary>
        /// الحصول على الراسئل بمقدا معين ولاكن يجب ان يكون الشخص الحالى طرف فى المحادثة
        /// </summary>
        /// <param name="chatId"></param>
        /// <param name="skip"></param>
        /// <param name="take"></param>
        /// <returns></returns>
        public object GetMessage(int chatId, int lastMessageId, int take)
        {
            int UserId = AccessToken.GetUserId(),
             Skip = 0;

            var Chat = db.Chattings.Find(chatId);
            if (Chat == null)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.ChatNotFound);

            if (UserId != Chat.FkUser_Id && UserId != Chat.Ad.FkUser_Id)
                return new ResponseVM(RequestTypeEnumVM.Error, Token.CanNotDisplayMessagsForYou);


            Chat.ChatMessages.Count(c => c.Id >= lastMessageId);

            var ChatMessages = Chat.ChatMessages.OrderByDescending(c => c.Id).Skip(Skip).Take(take).ToList();

            if (ChatMessages.Count == 0)
                return new ResponseVM(RequestTypeEnumVM.Info, Token.NoDataMore);

            return new ResponseVM(RequestTypeEnumVM.Error, Token.Success, GetChatMessgeDetails(ChatMessages));
        }

        /// <summary>
        ///  جلب المعلومات الازمة عن الراسائل
        /// </summary>
        /// <param name="chatMessages"></param>
        /// <returns></returns>
        public List<CahtMessageVM> GetChatMessgeDetails(List<ChatMessage> chatMessages)
        {
            return chatMessages.Select(c => new CahtMessageVM
            {
                Id = c.Id,
         AdId=       c.Chatting.FkAd_Id,
                Message = c.Message,
                SendDateTime = c.SendDateTime,
                UserName = c.UserName,
                FullName = c.FullName,
                UserImage = c.UserImage,
                IsOwnar = c.IsOwnar,
                IsFromMe = c.IsFromMe
            }).ToList();
        }
        /// <summary>
        //  جلب المعلومات الازمة عن الرسالة
        /// </summary>
        /// <param name="chatMessages"></param>
        /// <returns></returns>

        public CahtMessageVM GetChatMessgeDetails(ChatMessage chatMessage)
        {
            return new CahtMessageVM
            {
                Id = chatMessage.Id,
             AdId=   chatMessage.Chatting.FkAd_Id,
                Message = chatMessage.Message,
                SendDateTime = chatMessage.SendDateTime,
                UserName = chatMessage.UserName,
                FullName = chatMessage.FullName,
                UserImage = chatMessage.UserImage,
                IsOwnar = chatMessage.IsOwnar,
                IsFromMe = chatMessage.IsFromMe
            };
        }

        /// <summary>
        /// chat for ad
        /// </summary>
        /// <param name="chat"></param>
        /// <returns></returns>
        public object Chat(ChatSendVM chat)
        {
            try
            {
                PagesAllow PagesAllow = PageService.GetPageAllow(PageEnumVM.Ads);
                CreateS.db = db;
                ChatMessage ChatMessage = new ChatMessage();
                object ObjectReturn = CreateS.Chat(chat, ChatMessage, PagesAllow);
                if (ObjectReturn != null)
                    return ObjectReturn;

                db.SaveChanges();
                db = new SilgaramEntities();


                    ChatMessage = db.ChatMessages.Find(ChatMessage.Id);
                var Object = GetChatMessgeDetails(ChatMessage);

                //نتحقق من الذى ارسل الرسالة لـ نرسلها الى الطرف الآخر
                if (ChatMessage.Chatting.Ad.FkUser_Id==AccessToken.GetUserId())
                {
                    //ارسال الرسالة الى المستخدم الذى بداء المحادثة مع صاخب الاعلان 
                if (!string.IsNullOrEmpty(ChatMessage.Chatting.User.FireBaseToken))
                        FireBaseService.SendSpecificMessage(ChatMessage.Chatting.User.FireBaseToken, Object);
                }
                else
                {
                    //ارسال الرسالة الى الذى قام بـ انشاء الاعلان
                if (!string.IsNullOrEmpty(ChatMessage.Chatting.Ad.User.FireBaseToken))
                        FireBaseService.SendSpecificMessage(ChatMessage.Chatting.Ad.User.FireBaseToken, Object);
                }


                return new ResponseVM
                {
                    RequestType = RequestTypeEnumVM.Success,
                    Message = Token.Sent,
                    Data = new
                    {
                        ChatId = ChatMessage.Chatting.Id,
                        AdId=ChatMessage.Chatting.FkAd_Id,
                        CahtMessage = Object
                    }
                };
            }
            catch (Exception ex)
            {
                return new ResponseVM { RequestType = RequestTypeEnumVM.Error, Message = Token.SomeErrorInServer, DevMessage = ex.Message, InnerException = ex.InnerException };
            }
        }

        public void Dispose()
        {
            db.Dispose();
        }

   
    }//End Class
}
