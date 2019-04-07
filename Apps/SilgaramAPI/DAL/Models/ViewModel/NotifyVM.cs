using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Models.ViewModel
{
    public class NotifyVM
    {
        public string Date { get; internal set; }
        public int Id { get; internal set; }
        public bool IsCreateNewAuction { get; internal set; }
        public bool IsCreateNewOffer { get; internal set; }
        public bool IsCreateNewProduct { get; internal set; }
        public bool IsPrivateNotify { get; internal set; }
        public string ObjectDiscription { get; internal set; }
        public int ObjectId { get; internal set; }
        public string ObjectNme { get; internal set; }
        /// <summary>
        /// Send Notify With History ID
        /// </summary>
        /// <param name="id"></param>
        /// <param name="nameActionAr"></param>
        /// <param name="nameActionEn"></param>
        /// <param name="bodyAr"></param>
        /// <param name="bodyEn"></param>
        /// <returns></returns>
        public static object NotifyNode(int id,string nameActionAr, string nameActionEn, string bodyAr, string bodyEn)
        {
            return new
            {
                Id= id,
                NameActionAr = nameActionAr,
                NameActionEn = nameActionAr,
                BodyAr = bodyAr,
                BodyEn = bodyEn
            };
        }
        /// <summary>
        /// Send Notify Without History ID
        /// </summary>
        /// <param name="nameActionAr"></param>
        /// <param name="nameActionEn"></param>
        /// <param name="bodyAr"></param>
        /// <param name="bodyEn"></param>
        /// <returns></returns>
        public static object NotifyNode( string nameActionAr, string nameActionEn, string bodyAr, string bodyEn)
        {
            return new
            {
                NameActionAr = nameActionAr,
                NameActionEn = nameActionAr,
                BodyAr = bodyAr,
                BodyEn = bodyEn
            };
        }

        /// <summary>
        /// notify FireBase User Followinng
        /// </summary>
        /// <param name="nameAction"></param>
        /// <param name="body"></param>
        /// <param name="userIdFollowingYou"></param>
        /// <returns></returns>
        public static object NotifyNode(int usersFollowingYouId, string nameAction, string body)
        {
            return new
            {
                usersFollowingYouId = usersFollowingYouId,
                NameAction = nameAction,
                Body = body,
            };
        }



    }
}
