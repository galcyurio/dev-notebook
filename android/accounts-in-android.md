# `Accounts` in android
`AccountManager`는 안드로이드에서 account를 관리하기 위한 build-in 클래스다.
여기서 account란 `환경설정 -> 계정`에 들어가서 볼 수 있는 것을 의미한다.

## 장점
- 하나의 `account type`에서 앱 기능에 대한 액세스 수준이 다른 여러 `account name`을 저장할 수 있다.
- 사용자가 권한이 필요한 기능을 요청할 때마다 `username`과 `password`를 보내는 부분을 생략할 수 있다.
  인증은 백그라운드에서만 이루어지기 때문에 사용자는 특정 조건에서만 자신의 비밀번호를 묻는 메시지를 보게된다.
- 안드로이드의 `Account` 기능을 사용하면 자신의 `account type`을 정의할 필요가 없다.
  `Google` 계정과 같은 이미 존재하는 `account type`을 쓰면 사용자가 새로운 계정을 만들고 비밀번호를 기억해야 하는 번거로운 일들을 생략할 수 있다.
- 계정을 추가하는 기능을 앱과 독립적으로 수행할 수 있다. (환경설정 -> 계정)
- Cross-platform 환경에서 사용자 인증을 더 쉽게 수행할 수 있다. 예를 들어 클라이언트는 안드로이드 장치와 PC에서 동시에 보호되어 있는 것들에 대해 반복적인 로그인없이 접근할 수 있다.
- 안드로이드의 `Account` 기능을 사용하는 중요한 이유는 클라이언트의 `credentials`를 손상시키지 않으면서 계정에 종속된 비즈니스에 관련된 `authenticator`와 `resource owner`를 분리시키는 것이다.

## 현실세계에서의 예제
`회사 A`는 비디오 스트리밍을 운영하고 있고 계약하고 있는 `회사 B`는 특정 유저에게 프리미엄 스트리밍 서비스를 제공한다.
`B`는 사용자 인식을 위해 `username`과 `password`를 사용한다.
`A`에서 `B`의 프리미엄 사용자를 인식하려면 한 가지 방법은 `B`의 사용자 목록을 가져온 다음 똑같이 `username/password`가 일치하는지 확인하는 매커니즘을 사용해야 한다.
이 방식에서 `authenticator`와 `resource owner`는 같다 (`회사 B`). 
이 상황에서 사용자는 `A`, `B`에 같은 비밀번호를 사용할 확률이 높다. 이런 부분은 좋지 않다.

위에서 말한 단점을 완화하려고 `OAuth`가 나왔다.
`authorization`의 공개 표준이며 위의 예제로 보면 OAuth는 `회사 B`(authenticator)가 `authorization`을 수행하기 위해 자격이 부여된 사용자(third party)에 대한 `액세스 토큰`을 발급한 다음 `회사 A`(resource owner)에게 토큰을 제공하도록 한다.
따라서 `토큰이 없다`는 건 `자격이 없다`는 것을 의미한다.


## 계정 등록
첫번째 단계는 계정을 등록하는 것이다. 계정이 처음 추가될 때를 의미한다.
`AccountManager`에는 이를 위한 두 가지 메서드가 존재한다.

````java
public boolean addAccountExplicitly (Account account, String password, Bundle userdata)
````
`addAccountExplicitly()` 메서드는 `환경설정 -> 계정` 화면에 계정을 추가할 수 있다.

````java
public AccountManagerFuture addAccount (String accountType, String authTokenType, String[] requiredFeatures, Bundle addAccountOptions, Activity activity, AccountManagerCallback callback, Handler handler)
````

`addAccount()` 메서드는 반드시 다음과 같은 목적으로 쓰여야 한다.
이것은 앱 내부와 `설정 -> 계정`에서 둘 모두에서 새 계정을 추가하는데 쓰이는 메서드다.
이제 문제는 이 메서드의 구현이 두가지 계정 등록 방법에 모두 액세스 할 수 있어야 한다는 것이다.

계정 인증에 사용되는 기본적인 메서드를 가지고 있는 `AbstractAccountAuthenticator` 추상 클래스가 있다.
`AbstractAccountAuthenticator`에서 계정을 추가하는데 쓰이는 메서드로 `addAccount()`가 존재한다.
이 메서드는 계정 등록에 필요한 데이터를 받기 위한 유저 인터페이스를 보여줄 Activity를 시작하는 `Intent`를 담고 있는 `Bundle`을 반환한다.
이 메서드의 매개변수인 `accountType`과 `authTokenType`은 계정을 추가하기 전에 알아야 한다.
`accountType`은 보통 패키지명, 조직, 브랜드 이름, 기타 등등이 된다.
`authTokenType`은 `DEMO` 또는 `FULL`과 같은 액세스 레벨이나 그룹을 나타낸다.
샘플 구현은 다음과 같다.

````java
public class AppAccountAuthenticator extends AbstractAccountAuthenticator {

    private Context context;
    private Class<? extends RegistrationActivity> registrationActivityClass;

    public AppAccountAuthenticator(Context context) {
        super(context);
        this.context = context;
        loadRegistrationClassFromSharedPref();
    }

    @Override
    public Bundle addAccount(AccountAuthenticatorResponse response, String accountType, String authTokenType, String[] requiredFeatures, Bundle options) throws NetworkErrorException {
        Intent intent = makeIntent(response, accountType, authTokenType, requiredFeatures, options);
        Bundle bundle = makeBundle(intent);
        return bundle;
    }

    private Intent makeIntent(AccountAuthenticatorResponse response, String accountType, String authTokenType, String[] requiredFeatures, Bundle options) {
        Intent intent = new Intent(context, registrationActivityClass);
        intent.putExtra(AccountManager.KEY_ACCOUNT_TYPE, accountType);
        intent.putExtra(AccountManager.KEY_ACCOUNT_AUTHENTICATOR_RESPONSE, response);
        return intent;
    }

    private Bundle makeBundle(Intent intent) {
        Bundle bundle = new Bundle();
        bundle.putParcelable(AccountManager.KEY_INTENT, intent);
        return bundle;
    }
}
````

여기서 넘어가는 `RegistrationActivity`는 다음과 같은 역할을 수행해야 한다.
- `AccountAuthenticatorActivity` 클래스를 상속한다.
- Activity를 통해서 받은 필수 유저 정보와 함께 서버에 요청한다.
- 서버에서 유저 등록이 성공하면 
  - `addAccountExplicitly()` 메서드를 통해 실제로 계정을 추가한다.
  - 필수 유저정보를 포함하는 `Bundle`을 만들고 `setAccountAuthenticatorResult(bundle)`을 통해 결과를 돌려주도록 한다.

````java
public class RegistrationActivity extends AccountAuthenticatorActivity {
 
    private String accountName, accountType, authTokenType;
    private String[] requiredFeatures;
    private Bundle options;
 
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.
/* create your custom layout here */
/* get accountName, password and other required information from the user */
    }
 
    protected void register(String accountName, String password, String[] requiredFeatures, Bundle options) {
        Context context = getBaseContext();
        if (accountName == null || accountName.trim().isEmpty()) {
            Toast.makeText(context, context.getString(R.string.auth_msg_account_name_is_null), Toast.LENGTH_SHORT).show();
            return;
        }
        new RegisterAsync(context, accountName, password, requiredFeatures, options).execute();
    }
 
    private class RegisterAsync extends AsyncTask {
 
        private Context context;
        private String accountName;
        private String password;
        private String[] requiredFeatures;
        private Bundle options;
        private Account account;
        private RegisterResult registerResult;
 
        public RegisterAsync(Context context, String accountName, String password, String[] requiredFeatures, Bundle options) {
            this.context = context;
            this.accountName = accountName;
            this.password = password;
            this.requiredFeatures = requiredFeatures;
            this.options = options;
        }
 
        @Override
        protected Object doInBackground(Object[] params) {
            account = new Account(accountName, accountType);
/* This is the method for making registration request to the server, it would be better to define it outside of this class */
            registerResult = registerInServer(context, account, password, authTokenType, requiredFeatures, options);
            return null;
        }
 
        @Override
        protected void onPostExecute(Object o) {
            if (registerResult.isSuccessful) {
                String refreshToken = registerResult.refreshToken;
                AccountManager.get(context).addAccountExplicitly(account, refreshToken, options);
                Bundle bundle = makeBundle(accountName, accountType, authTokenType, refreshToken, options);
                setAccountAuthenticatorResult(bundle);
                finish();
            } else {
                throw new RuntimeException("User registration is not successful in authenticator due to the following error:/n" +
                        registerResult.errMessage);
            }
        }
    }
 
    private Bundle makeBundle(String accountName, String accountType, String authTokenType, String refreshToken, Bundle options) {
        Bundle bundle = new Bundle();
        bundle.putString(AccountManager.KEY_ACCOUNT_NAME, accountName);
        bundle.putString(AccountManager.KEY_ACCOUNT_TYPE, accountType);
        bundle.putString(AccountManager.KEY_PASSWORD, refreshToken);
        return bundle;
    }
}
````

위 코드를 보면 `registerInServer()`를 통해서 유저 등록이 성공하는 경우 `refreshToken`이 반환되는 것을 볼 수 있다. 안드로이드에서는 `refreshToken`을 `addAccountExplicitly (Account account, String password, Bundle userdata)` 메서드를 이용해서 `password`에 저장할 수 있다.
오해할 수도 있지만 `password`는 계정 등록 요청을 보내는 `registerInServer()` 에서만 쓰이고 장치의 어느 곳에도 저장되지 않는다.
이는 `password`가 `user`가 `provider`의 전체 서비스를 사용할 수 있는 권한을 가지고 있으며 침해당해서는 안되는 것이기 때문이다.
구글은 여기에 대해 강력히 권고하고 있으며 보안 전문가의 도움을 받으라고 한다.
유저의 기기에 암호화가 되었든 안되었든 그 어떤 종류의 비밀번호도 저장하지 않는 것이 좋다.
이것이 OAuth 2.0이 전통적인 인증 방법을 대체한 주된 이유다.

구글을 예로 들어보자.
구글은 여러가지 앱과 서비스들을 가지고 있고 이 것들은 비밀번호 하나로 모두 접근이 가능하다.
따라서 만약 이 유니크한 비밀번호가 구글의 앱에 의해서 장치에 `addAccountExplicitly()` 메서드를 이용해 저장된다면 루팅된 기기에서는 쉽게 접근이 가능하다.
루팅되지 않은 기기라면 안드로이드는 `authenticator`와 다른 UID 서명을 가진 앱이 `AccountManager`의 `setPassword()` 메서드를 호출하는 것을 막음으로써 이를 방지한다.

따라서 `refreshToken`이 실제 비밀번호 대신에 저장되어야 한다.
토큰이 노출되는 경우는 어떻게 할 것인지에 대해서는 조금 뒤에 설명한다.

`setAccountAuthenticatorResult(bundle)`이 호출되면 유저는 `addAccount()`를 호출했던 곳으로 되돌아 온다.
만약 계정 등록이 `환경설정 -> 계정` 화면을 통해서 이루어지면 다른 추가 단계 없이 계정이 추가된다.
하지만 앱 내부에서 계정이 등록되면 `AccountManagerCallback`을 통해 다음 단계가 수행된다.
`AccountManager`의 `addAccount` 메서드를 자세히 살펴보자.

```java
public AccountManagerFuture addAccount (String accountType, String authTokenType, 
String[] requiredFeatures, Bundle addAccountOptions, Activity activity, 
AccountManagerCallback callback, Handler handler)
```

환경설정을 통한 계정 등록은 안드로이드에 의해서 `callback` 파라미터로 null이 넘어간다.
앱 내부에서 수행되었을 때는 이 `callback`을 통해서 `accessToken`을 얻어오는 등의 추가적인 인증 단계를 수행할 수 있다.  
결론적인 부분은 `AccountManager`가 관련 메서드를 호출하기 위해 `AbstractAccountAuthenticator`를 확장하는 클래스에 대해서 알아야 하냐는 것이다.
이것은 바인딩된 `Service`을 통해 이루어진다.
실제로 `accountManager.addAccount`가 사용되면 `android.accounts.AccountAuthenticator`라는 작업을 브로드캐스팅하며 이 작업은 `AbstractAccountAuthenticator`를 확장한 클래스를 인스턴스화하는 바운드 서비스를 호출한다.
`manifest.xml`에 추가해야할 내용은 다음과 같다.

````xml
<service android:name="com.digigene.accountauthenticator.AuthenticatorService">
    <intent-filter>
        <action android:name="android.accounts.AccountAuthenticator" />
    </intent-filter>
    <meta-data
        android:name="android.accounts.AccountAuthenticator"
        android:resource="@xml/authenticator" />
</service>
````

`resource meta-data`를 주의깊게 보아야 한다.
다음은 `authenticator`가 작동하기 위해서 추가해야 하는 `xml` 파일이다. 

````xml
<?xml version="1.0" encoding="utf-8"?>
<account-authenticator xmlns:android="http://schemas.android.com/apk/res/android"
    android:accountType="@string/auth_account_type"
    android:icon="@mipmap/ic_launcher"
    android:label="@string/auth_account_type"
    android:smallIcon="@mipmap/ic_launcher"
    />
````

이 `xml`파일을 제대로 설정하지 않으면 계정 `authenticator`가 제대로 작동하지 않아 서비스가 시작되지 않는다.
아래는 바인딩된 서비스를 정의하는 샘플 코드다.

````java
public class AuthenticatorService extends Service {

    @Override
    public IBinder onBind(Intent intent) {
        AppAccountAuthenticator appAccountAuthenticator = new AppAccountAuthenticator(this);
        return appAccountAuthenticator.getIBinder();
    }

}
````

## 계정 인증 (Account authentication)
간단하게 말하자면 `accessToken`을 얻는 작업이다.
서버 검증시 유효하다면 사용자는 보호된 서비스에 접근할 수 있다.
처음 시작은 **계정 등록**처럼 `AccountManager`를 통해 이루어진다.

````java
AccountManager accountManager = AccountManager.get(context);
accountManager.getAuthToken(account, authTokenType, options, activity, accountManagerCallback, handler);
````

`accountManagerCallback`은 액세스 토큰을 얻은 후에 실행되며 서버와의 액세스 토큰 유효성 검사를 처리 할 수 ​​있습니다.

등록과 마찬가지로 `AbstractAccountAuthenticator`는 `getAuthToken()`을 통해서 계정을 인증하는 작업을 수행할 수 있다.
`AbstractAccountAuthenticator` 클래스를 구현한 구현체에서는 다음과 같이 4가지 단계를 수행해야 한다.

````java
@Override
public Bundle getAuthToken(AccountAuthenticatorResponse response, Account account, String authTokenType, Bundle options) throws NetworkErrorException {
    AuthenticatorManager authenticatorManager = AuthenticatorManager.authenticatorManager;
    Bundle result;
    AccountManager accountManager = AccountManager.get(context);
    // case 1: access token is available
    result = authenticatorManager.getAccessTokenFromCache(account, authTokenType, accountManager);
    if (result != null) {
        return result;
    }
    final String refreshToken = accountManager.getPassword(account);
    // case 2: access token is not available but refresh token is
    if (refreshToken != null) {
        result = authenticatorManager.makeResultBundle(account, refreshToken, null);
        return result;
    }
    // case 3: neither tokens is available but the account exists
    if (isAccountAvailable(account, accountManager)) {
        result = authenticatorManager.makeResultBundle(account, null, null);
        return result;
    }
    // case 4: account does not exist
    return new Bundle();
}
````

1. AccountManager에 이전의 `accessToken`이 남아있는지 체크하고 있으면 
2. 없다면 `getPassword()`를 통해서 `refreshToken`이 존재하는지 체크한다.

<!-- TODO -->