# authroization grant types

## authorization code
- authorization code 는 client 와 resource server 간의 중재 역할을 하는 authorization server 로부터 얻을 수 있다. 
- resource owner 로부터 직접적으로 authorization 을 요청하는 대신에, client 는 resource owner 를 authorization server 로 보내고 authorization server는 resource owner 를 authorization code 와 함께 client 로 돌려 보낸다.
- access token 을 바로 발급하지 않기 때문에 보안이 강하다

## implicit
- authorization code 방식이 간소화 된 방식이며 javascript 와 같은 스크립트 언어로 만들어진 브라우저에 최적화 되어있다. 
- authorization code 를 발급하지 않고 대신에, resource owner 가 client 에게 직접 access token 을 발급한다.
- access token 을 발급하는 도중에 authorization server 는 client 를 authenticate 하지 않는다.
- 어떤 경우에는 access token 을 client 에 전달하는 데 사용된 redirect URI 를 통해 client identity 를 확인 할 수 있다.
- access token 을 발급하는 과정에서 왕복 횟수가 줄어들어서 효율성이 높아질 수 있다.
- 이 편리한 방식은 보안적으로 [RFC6749-10.3](https://tools.ietf.org/html/rfc6749#section-10.3), [RFC6749-10.16](https://tools.ietf.org/html/rfc6749#section-10.16) 와 같은 문제가 있다. 특히 authorization code 인증 방식을 사용할 수 있는 경우에..

## resource owner password credentials
- resource owner password credentials(username, password) 을 통해 직접적으로 access token 을 얻을 수 있다. 
- resource owner 와 client 관계의 신뢰도가 높을 경우와 다른 인증 방식을 사용할 수 없는 경우에 사용하여야 한다.
- 이 방식이 resource owner credentials 에 대한 client 의 직접적인 접근을 요구하더라도 resource owner credentials 는 단일 요청에 사용되며 access token 으로 교환된다.
- long-lived access token 또는 refresh token 을 얻음으로써 resource owner password credentials 를 저장할 필요가 없어진다.

## client credentials
- client authentication 이라고도 불린다.
- resource owner 의 주체가 end-user 가 아닌 client가 되는 상황에서 쓰인다.
- authorization scope 가 client 의 관리하에 있는 protected resources 로 제한된다.
- client(resource owner) 가 자신을 대신하여 요청할 때 또는 이전에 authorization server 에서 부여된 authorization 으로 보호되는 resources 를 요청할 때 사용된다.

<hr />

## access token
- access token 은 protected resources 에 접근 하기 위한 credentials 이다.
- token 은 특정 scopes 와 일정 기간의 접근을 나타낸다.
- resource owner 로부터 허가 받는다.
- resource server 와 authorization server 가 사용한다.

<hr />

# Client types
authorization server 로부터 보안적으로 인증을 받는 능력(client credentials 정보를 보안 유지하는 능력)에 따라서 2가지의 client type으로 나뉜다.

## confidential client
- client credentials 에 대해서 보안적으로 유지가 가능한 경우이다.

## public client
- client credentials 정보를 보안적으로 유지할 수 없는 경우이다. (native application, web browser-based application)

<hr />

## 예시
### web application
- confidential client
- resource owner 는 본인이 사용하는 장치의 user-agent 에서 렌더링된 HTML user interface 를 통해 client 에 접근한다.

### user-agnet based application
- public client 
- client 코드가 웹서버로부터 다운로드 되고 user-agent 에서 실행되어진다.
- Protocol 데이터와 credentials 에 접근하기 쉽다.
- user-agnet 내에 있기 때문에 권한을 요청할 때 user-agent 기능을 원활하게 사용할 수 있다.

### native application
- public client
- resource owner 가 사용하는 device 에서 설치되고 실행된다.
- resource owner 가 protocol data 와 client credentials 에 접근할 수 있다. 따라서 client credentials 가 유출 될 수 있다는 것을 의미한다.
- access token 과 refresh token 과 같이 동적으로 생성되는 credentials 에는 어느 정도의 보안이 필요하다. 최소한 앱과 상호작용할 수 있는 적대적인 서버들로부터 보호할 수 있어야 한다. 일부 플랫폼에서는 이러한 credentials 를 안전하게 저장 할 수 있는 장소를 제공한다.


<hr />


# Authorization Code Grant
confidential client 에 최적화된 방식이며 access token 과 refresh token 을 얻는데 사용할 수 있다. 이러한 redirection-based flow 에서는, client 가 resource owner 의 user-agent 에 상호작용할 수 있어야 한다. 그리고 redirect 을 통해 authorization server 로부터 들어오는 요청들도 받을 수 있어야 한다.

__Authorization code flow__
1. client 가 resource owner 의 user-agent 를 통해서 authorization endpoint 로 요청한다. 이 때 client identifier, requested scope, local state and redirection URI 가 포함되어야 한다.
1. authorization server 가 resource owner 에 대해서 authenticate 하고 resource owner 가 권한 요청에 대해서 허용할 지 거부할 지를 결정한다.
1. 허용했다고 가정하면, authorization server 는 user-agent 를 redirect uri 를 이용해서 client 에게로 다시 돌려 보낸다. 이 때 redirect URI 는 authorization code 와 client 가 이전에 제공한 local state 를 포함해야 한다.
1. client 는 authorization code 를 포함하여 authorization server 에 access token 을 요청한다. 요청이 만들어질 때 client 는 authorization server 로 인증한다. client 는 이 요청에 authorization code 를 얻을 때 썼던 redirect URI 를 포함시킨다.
1. authorization server 가 client 를 인증하고 넘어온 authorization code 의 유효성을 확인한다. 그리고 넘어온 redirect URI 가 authorization code 를 얻을 때 썼던 redirect URI 와 같은지 확인한다.  모두 유효하다면, access token 과 refresh token(optional) 과 함께 응답한다.


## Authorization Request
client 는 "application/x-www-form-urlencoded" format 으로 request URI 를 다음 parameters 를 더하여 만들어야 한다.
- response_type (Required) : 반드시 'code ' 이어야 한다.
- client_id (Required)
- redirect_uri (Optional)
- scope (Optional)
- state (Recommended) : request 와 callback 사이의 상태를 저장하기 위한 값, CSRF 공격을 막기위해 사용된다.

## Authorization Response
resource owner 가 접근 요청에 대해 허가를 받으면 authorization server 는 authorization code 를 발행하고 client 다음 parameters 를 통해 넘겨준다.
- code (Required) : 
생략...


<hr />

# Implicit Grant
refresh token 을 지원하지 않으며 public clients 에 최적화 되어있다. 이 clients 는 주로 javascript 로 만들어진 browser 기반의 clients 이다.
flow 는 authorization code flow 와 흡사하다.

<hr />


# Resource Owner Password Credentials Grant
public client 와 confidential client 모두 사용 가능하다.
1st party 를 위한 grant type 이며 믿을 수 있는 관계의 client 와 resource owner 간에 사용될 수 있다. client 가 resource owner 의 credentials(username, password) 를 얻을 수 있는 환경에 알맞다.

__Flow__
1. resource owner 가 client 에게 username 과 password 를 제공한다.
1. resource owner 의 credentials 를 포함하여 authorization server 의 token endpoint 로 access token 을 요청한다.
1. authorization server 에서 넘어온 resource owner password credentials 를 확인하고 유효하면 access token 을 발행한다.

<hr />

# Client Credentials Grant

__Flow__
1. clinet 가 authorization server 로부터 authenticate 하고 access token 을 요청한다.
1. authorization server 가 client 를 authenticate 하고 유효하면 access token 을 발행한다.