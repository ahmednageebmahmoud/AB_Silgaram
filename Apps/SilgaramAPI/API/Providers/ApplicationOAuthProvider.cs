using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using API.Models;
using DAL.Resource;
using DAL.Service;
using DAL.Models.ViewModel;
using DAL.Models;

namespace API.Providers
{
    public class ApplicationOAuthProvider : OAuthAuthorizationServerProvider
    {
        private readonly string _publicClientId;

        public ApplicationOAuthProvider(string publicClientId)
        {
            if (publicClientId == null)
            {
                throw new ArgumentNullException("publicClientId");
            }

            _publicClientId = publicClientId;
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            try
            {
                CheckedService CheckedS = new CheckedService();
                UserService UserS = new UserService();
                string Culture = LanguageService.DefaultLangage;

                //check user valid 
                //if (!CheckedS.UserNamePasswordIsValid(context.UserName, context.Password))
                //{
                //    context.SetError(Token.Error, Token.InvalidData);
                //    return;
                //}

                //get user 
                User CurrentUser = UserS.GetUserByUserName(context.UserName);
                if (CurrentUser.UserInformation.Language == null)
                    Culture = "ar";
                else if (CurrentUser.UserInformation.Language.LanguageUsings != null)
                    if (CurrentUser.UserInformation.Language.LanguageUsings.Any(c => c.IsDefault))
                        Culture = CurrentUser.UserInformation.Language.LanguageUsings.Where(c => c.IsDefault).Single().LanguageType.Code;
                   
                LanguageService.SetCulture(Culture);

                /*
                 * Check user role mustbe if Client or Client
                 **Notes** any user login in app basically included role client  
                */
                if (!CheckedS.Roles(CurrentUser.UserRoles, new int[] { RoleEnumVM.Client }))
                {
                    context.SetError("Error", Token.YouNotClient);
                    return;
                }

                var identity = new ClaimsIdentity(context.Options.AuthenticationType);
                identity.AddClaim(new Claim(ClaimTypes.Name, CurrentUser.UserInformation.FullName));
                identity.AddClaim(new Claim(ClaimTypes.Name, context.UserName));

                    //any user login in app basically included role client  
                    identity.AddClaim(new Claim(ClaimTypes.Role, "client"));
                identity.AddClaim(new Claim("Culture", Culture));

                identity.AddClaim(new Claim(ClaimTypes.Email, CurrentUser.Email));
                identity.AddClaim(new Claim("UserId", CurrentUser.Id.ToString()));
                identity.AddClaim(new Claim("Serial", CurrentUser.Serial));

                context.Validated(identity);

            //    context.Request.Context.Authentication.SignIn(identity);
            }
            catch  (Exception ex)
            {
                context.SetError("Error", Token.Error);
                context.SetError("DevMessage", ex.Message);
            }

        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            // Resource owner password credentials does not provide a client ID.
            if (context.ClientId == null)
            {
                context.Validated();
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientRedirectUri(OAuthValidateClientRedirectUriContext context)
        {
            if (context.ClientId == _publicClientId)
            {
                Uri expectedRootUri = new Uri(context.Request.Uri, "/");

                if (expectedRootUri.AbsoluteUri == context.RedirectUri)
                {
                    context.Validated();
                }
            }

            return Task.FromResult<object>(null);
        }

        public static AuthenticationProperties CreateProperties(string userName)
        {
            IDictionary<string, string> data = new Dictionary<string, string>
            {
                { "userName", userName }
            };
            return new AuthenticationProperties(data);
        }
    }
}