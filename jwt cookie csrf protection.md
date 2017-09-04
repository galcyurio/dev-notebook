1. HttpOnly 와 secure 모드로 cookie 에 저장하여 https 프로토콜로 서버에 전송한다.

2. 대부분의 CSRF 공격은 origin과 referrer 헤더가 다른경우가 많으므로 이 헤더들을 체크한다.

3. javascript는 다른 웹사이트의 cookie 를 읽어낼 수 없으며 이것을 이용하면 CSRF 공격을 막아 낼 수 있다.
 먼저 javascript 로 읽을 수 있는 cookie에 XSRF-TOKEN 를 만들어야 한다.
 이 cookie 는 유저가 로그인 했을 때 만들어져야 하면 랜덤하여 예측할 수 없는 값들이 포함되어야 한다.
 그리고 모든 요청에 custom header 를 만들어 값으로 XSRF-TOKEN 을 보내야한다.



Angular JS makes your life easy

Fortunately I am using Angular JS in our platform and Angular packages the CSRF token approach, making it simpler for us to implement. For every request that our Angular application makes of the server, the Angular $http service will do these things automatically: Look for a cookie named XSRF-TOKEN on the current domain. If that cookie is found, it reads the value and adds it to the request as the X-XSRF-TOKEN header.

Thus the client-side implementation is handled for you, automatically! We just need to set a cookie named XSRF-TOKEN on the current domain in server side and when our API got any call from client, it must check X-XSRF-TOKEN header and compare it with the XSRF-TOKEN in the JWT. if they are matched then user is real. if not matched then its a forged request and you can ignore this request. This method is inspired by Double Submit Cookie Method.

Caution

In reality you are still susceptible to XSS, it's just that attacker can't steal you JWT token for later use, but he can still make requests on your users behalf using XSS.

Whether you store your JWT in a localStorage or you store your XSRF-token in not http-only cookie, both can be grabbed easily by XSS. Even your JWT in HttpOnly cookie can be grabbed by an advanced XSS attack like XST METHOD.

So in addition of the Double Submit Cookies method, you must always follow best practices against XSS including escaping contents. This means removing any executable code that would cause the browser to do something you don’t want it to. Typically this means removing //