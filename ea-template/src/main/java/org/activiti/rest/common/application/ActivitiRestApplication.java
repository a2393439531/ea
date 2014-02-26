/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.activiti.rest.common.application;

import javax.servlet.http.HttpSession;

import org.activiti.rest.common.api.ActivitiUtil;
import org.activiti.rest.common.filter.RestAuthenticator;
import org.restlet.Application;
import org.restlet.Request;
import org.restlet.Response;
import org.restlet.data.ChallengeResponse;
import org.restlet.data.ChallengeScheme;
import org.restlet.ext.servlet.internal.ServletCall;
import org.restlet.security.ChallengeAuthenticator;
import org.restlet.security.SecretVerifier;
import org.restlet.security.Verifier;

import com.app.ea.model.User;
/**
 * @author Tijs Rademakers
 */
public abstract class ActivitiRestApplication extends Application {
  
  protected ChallengeAuthenticator authenticator;
  protected ActivitiStatusService activitiStatusService;
  protected MediaTypeResolver mediaTypeResolver;
  protected RestAuthenticator restAuthenticator;

  public ActivitiRestApplication() {
    activitiStatusService = new ActivitiStatusService();
    setStatusService(activitiStatusService);
  }
  
  public MediaTypeResolver getMediaTypeResolver() {
    if(mediaTypeResolver == null) {
      // Revert to default implementation when no custom resolver has been set
      mediaTypeResolver = new DefaultMediaTypeResolver();
    }
    
    return mediaTypeResolver;
  }
  
  public void setRestAuthenticator(RestAuthenticator restAuthenticator) {
    this.restAuthenticator = restAuthenticator;
  }

  public void setMediaTypeResolver(MediaTypeResolver mediaTypeResolver) {
    this.mediaTypeResolver = mediaTypeResolver;
  }
  
  public void initializeAuthentication() {
	  System.out.println("-------------> Start Auth!");
    Verifier verifier = new SecretVerifier() {

      @Override
      public boolean verify(String username, char[] password) throws IllegalArgumentException {
        //如果需要和自己的表关联，这里需要换成去我们的用户验证API
        //boolean verified = ActivitiUtil.getIdentityService().checkPassword(username, new String(password));
    	  System.out.printf("username:%s password:%s%n" , username , new String(password) );  
	        /** 
	         * 此处自定义的验证规则为：如果用户名不为空，并且用户名和密码相等则通过。否则不通过 
	         */  
	        if(username == null || username.equals("")){  
	            return false;  
	        }else if(username.equals( new String(password) )){  
	            return true;
	        }else{  
	            return false;  
	        }  
      }
    };
    
    // Set authenticator as a NON-optional filter. If certain request require no authentication, a custom RestAuthenticator
    // should be used to free the request from authentication.
    authenticator = new ChallengeAuthenticator(null, true, ChallengeScheme.HTTP_BASIC,
          "Activiti Realm") {
      
      @Override
      protected boolean authenticate(Request request, Response response) {
        
        // Check if authentication is required if a custom RestAuthenticator is set
        if(restAuthenticator != null && !restAuthenticator.requestRequiresAuthentication(request)) {
          return true;
        }
        
        if (request.getChallengeResponse() == null) {
          return false;
        } else {
          boolean authenticated = super.authenticate(request, response);
          if(authenticated && restAuthenticator != null) {
            // Additional check to see if authenticated user is authorised. By default, when no RestAuthenticator
            // is set, a valid user can perform any request.
            authenticated = restAuthenticator.isRequestAuthorized(request);
          }
          return authenticated;
        }
      }
    };
    authenticator.setVerifier(verifier);
  }
  
	public String authenticate(Request request, Response response) {
		
		if (!request.getClientInfo().isAuthenticated()) {
			HttpSession session = ServletCall.getRequest(request).getSession();
			User loggedInUser = (User) session.getAttribute("userlogined");
			if (loggedInUser != null) {
				return loggedInUser.getAccount();
			}else {
				authenticator.challenge(response, false); //使用HTTP_BASIC基础认证
				return null;
			}
		}
		return request.getClientInfo().getUser().getIdentifier();
		// if (!request.getClientInfo().isAuthenticated()) {
		// authenticator.challenge(response, false);
		// return null;
		// }
		//
		// return request.getClientInfo().getUser().getIdentifier();
	}
}
