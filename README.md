<!--
  Title: Shibboleth SP Docker
  Description: Builds Shibboleth SP3 docker image with Apache HTTP-server and SSL installed in CentOS 8
  Author: Dmitry Losev
  -->

# Shibboleth SP Docker

## Info

Creates [Shibboleth SP3](https://shibboleth.atlassian.net/wiki/spaces/SP3/overview) **3.2.3** docker image. The SAML Service
Provider runs in _CentOS 8_ behind _Apache HTTP-server_. SSL-certificates
for SP are generating at startup.

There are following variables that can be edited in [Dockerfile](Dockerfile):

* SHIBBOLETH_VERSION - Version of the Shibboleth SP to install, eg `3.2.3-3.1.x86_64`;
* SERVER_NAME - Domain name for the Shibboleth SP, eg `shibboleth-sp.com`.

Tested with local [Keycloak](https://www.keycloak.org) docker container instance.

## How to use

1. Edit [shibboleth2.xml](shibboleth/shibboleth2.xml) file to replace `https://saml-idp.example.com` with your SAML IDP's address.
2. Build the docker image:
    ```bash
    docker build --tag shibboleth-sp .
    ```
3. Run Shibboleth SP:
    ```bash
    docker run --name shibboleth-sp -p 443:443 shibboleth-sp
    ```
4. Add the following record to the `/etc/hosts` file on your local machine
    ```bash
    127.0.0.1       shibboleth-sp.com
    ```
5. The following URLs are available:
   * https://shibboleth-sp.com/Shibboleth.sso/Login - Login to SP with IDP;
   * https://shibboleth-sp.com/Shibboleth.sso/Metadata - SP metadata;
   * https://shibboleth-sp.com/Shibboleth.sso/Session - See current session details, eg SAML-attributes passed from IDP;
   * https://shibboleth-sp.com/Shibboleth.sso/Logout - SLO and local logout;

Generated SP metadata example:
```xml
<!--
This is example metadata only. Do *NOT* supply it as is without review,
and do *NOT* provide it in real time to your partners.
 -->
<md:EntityDescriptor xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata" ID="_cfcbdee9a6eaa1cb82cbf006de1efa06c730d5a6" entityID="https://shibboleth-sp.com/Shibboleth.sso">

  <md:Extensions xmlns:alg="urn:oasis:names:tc:SAML:metadata:algsupport">
    <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha512"/>
    <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#sha384"/>
    <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
    <alg:DigestMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#sha224"/>
    <alg:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha512"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha384"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha256"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha224"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha512"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha384"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2009/xmldsig11#dsa-sha256"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha1"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
    <alg:SigningMethod Algorithm="http://www.w3.org/2000/09/xmldsig#dsa-sha1"/>
  </md:Extensions>

  <md:SPSSODescriptor protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
    <md:Extensions>
      <init:RequestInitiator xmlns:init="urn:oasis:names:tc:SAML:profiles:SSO:request-init" Binding="urn:oasis:names:tc:SAML:profiles:SSO:request-init" Location="https://shibboleth-sp.com/Shibboleth.sso/Login"/>
    </md:Extensions>
    <md:KeyDescriptor use="signing">
      <ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
        <ds:KeyName>buildkitsandbox</ds:KeyName>
        <ds:X509Data>
          <ds:X509SubjectName>CN=buildkitsandbox</ds:X509SubjectName>
          <ds:X509Certificate>MIID/zCCAmegAwIBAgIUWMsDKNlNEfURDRycxPu79P/WpeUwDQYJKoZIhvcNAQEL
BQAwGjEYMBYGA1UEAxMPYnVpbGRraXRzYW5kYm94MB4XDTIxMTExNjIwNDgxN1oX
DTMxMTExNDIwNDgxN1owGjEYMBYGA1UEAxMPYnVpbGRraXRzYW5kYm94MIIBojAN
BgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAuLoxP5i1NhebpgAyW/QMJxVjs3ua
a0hxpJz7HjxKH9lOKWYii0N5x8B/GZKlRpJleeMSigG3TKG41vTgwktlz3sLIv8s
1UNIkPVQDZHjg0mVORZGV/TWiTKWL/fX3+KccUIoTv/hSY6aoJ9VH0Bc/TmI605p
hzrl/Uha9MpEqBPnmrdMVtRWzHH0ubmJqEOnRPrF7bLD7lt0+eisByIVNut3KX7X
TC6oCyRaZcftC8j/HA9Te6Ax6xR3WL8exHsM0YGKj6uAaWYjmgMI1uBHOY53RwP/
ALbekRf/rruq24IOji9ZM3p44dWKof/ab52HLGRVopZpAFkuswpUss/pjAXw+vhn
NJKgwhQ/4mHJtx4X0i0JA4v7Rr3Tp/zqWmdxQTkrrXcvzKSHObaAd3dROTpU7BW1
LALPX8JScZbwgkfFTZMPATBgI1O3FQigXmEqLZaPKoH0Im/5/dj42gmgtL0fUibC
2nVYjFOIK6VVVvHNgkpQx0k5/3lG+KDkg3+NAgMBAAGjPTA7MBoGA1UdEQQTMBGC
D2J1aWxka2l0c2FuZGJveDAdBgNVHQ4EFgQUB4mfUlr2AFHcwXoLgM+99PnTiLgw
DQYJKoZIhvcNAQELBQADggGBAEhy+2ryswi4kZHQzThaQH8DNIxQw6SXW7upt0Q1
la055yeZHjwm0Ale2drPF1ckZQRovLyzR1wNGeX8XjlDg0FCx3jvo7tHRPbGZ0zi
RC8n/3qrdrN4oVPmNNFX2f8NxoBcA3weiljDmrXZSkUB6tAaZxtCXsOn/7J7iYfp
f5HoiW+Vor4q1QHJjCO6GTYU+dGqtgh3hYZPp3GSEpoZiSsiD1axJ1VR6go02uq6
tmW7QExsLaAtT6W1CCQiTjE4JUBMsM7qOvhwBTcEiLbxvnvEJsmub3B0wT7WudDQ
u+a98fYqMHVrfBU2PZcH6phFt8BUnnVh6GmEk/CiUdlPsI6eHORgNkCUM2KgbnOs
cK8JKy6f7efr3rrOFkEk4C9ZLjl4rQPslvcwzDv02CHKpYEd55DVZ30Z7cSroGqm
9sPSHHkJsZv9Qfx+01Fqdvq8gEfsfcLBW8jJ049cQRuIUCGEnK1estmrbAGMVpsx
rnjKPxhk+kPjoqtFAzcYyV34MA==
</ds:X509Certificate>
        </ds:X509Data>
      </ds:KeyInfo>
    </md:KeyDescriptor>
    <md:KeyDescriptor use="encryption">
      <ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
        <ds:KeyName>buildkitsandbox</ds:KeyName>
        <ds:X509Data>
          <ds:X509SubjectName>CN=buildkitsandbox</ds:X509SubjectName>
          <ds:X509Certificate>MIID/zCCAmegAwIBAgIUV77ZSEyfw92CMP1GWFJD1JgcZkkwDQYJKoZIhvcNAQEL
BQAwGjEYMBYGA1UEAxMPYnVpbGRraXRzYW5kYm94MB4XDTIxMTExNjIwNDgxOFoX
DTMxMTExNDIwNDgxOFowGjEYMBYGA1UEAxMPYnVpbGRraXRzYW5kYm94MIIBojAN
BgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEA94lrG/r1xbSHh1gVIps0Wd4B8Dsn
97ZcUSYe50+YHERkxH/+OIEP/l9K9XEF4EjhCsxlP49H3u4eEv6pHCbEVAmPXslV
SaP2ABfL947qyLx3PGkS/wVdt9i9ZoAG94WT5UGcEso3btMNjhyXUl2dreTVzuVO
Q8FAjHxS6VwcVLqNy6BPXIVIquAbYiskTzH12U/WwPlQrVIwJ5jY1ayz6JbcWJpb
zYBsHpVNn1jAWPpVc3TTcnOey5lcfO2XS5m72CnotuoPhCIC0xR4iNq2iNl2eYtc
TUEHyGhS5ybxtE3VxFI7OdxNtlpPEIvNAcYftWJId0OZ2eZBrRLyD5SaAe82guau
xmSVSezHKHTAhPI/IT+H1MvMAZ9oMvS5nMLBHIzg5m1LS1x9pU22whCGnE5dDrsT
cGAmSEpIwkrBLrqwZY5JZL4y6Wzh8brv6XOaz7P8R9rvpaTByajDyAJHDM7WFyZ4
HF8FDEfkf7bAx+7U9ouftnXpEbEr1YNLgqjnAgMBAAGjPTA7MBoGA1UdEQQTMBGC
D2J1aWxka2l0c2FuZGJveDAdBgNVHQ4EFgQUgBZ2sOd+wXOVCS9deHqM5y67KH8w
DQYJKoZIhvcNAQELBQADggGBAE9r33WNdqcALkCVgHFZqpROPbKuopBtodOe99DR
L4ocHvJqwk28O+k3YD1QY41bFNV1DAk0IjlCFKUBTBlVFsrkPA+Uywfsg82ve/2x
l2nP/8FgPSvDTxOLvi0/osKYiYisaL9qKptyh39sz7ISbVrbNqJ1BHM2kJ8mqvMK
ngLu5tMXypEXD3jFcfplAmcg4kRgLvxyH+qRVOP/jVRQkuwpTLkpGIxBTDsz30Hy
hh2gizzRrsokdJ6F8JxF2CwMUacjkJu+CnpG9/f3Z9cE+YMLnqz6Ok48v7wifCbt
OJO5wsBQdmU5RJCrWj2RQr1Gmcn02tPwj+VQbVDjHGy6mZ5BSlUKiQ3Q//2m6+cE
3JudPor9Ktl5rRuj8OQ/U3RMOAqd7WStF0mAsQBN5aZQpHkBpOeZZCMEuACjtBWO
Qf6ptEJtR9cvWSznveeyRvQiUyqDca4yzcBCBnj47ovJuDMTDnX4DYBP2/1DqQ56
3JRRQKGRcmkme+EhER3ZK6UWOQ==
</ds:X509Certificate>
        </ds:X509Data>
      </ds:KeyInfo>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#aes128-gcm"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#aes192-gcm"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#aes256-gcm"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#aes128-cbc"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#aes192-cbc"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#aes256-cbc"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#tripledes-cbc"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2009/xmlenc11#rsa-oaep"/>
      <md:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#rsa-oaep-mgf1p"/>
    </md:KeyDescriptor>
    <md:ArtifactResolutionService Binding="urn:oasis:names:tc:SAML:2.0:bindings:SOAP" Location="https://shibboleth-sp.com/Shibboleth.sso/Artifact/SOAP" index="1"/>
    <md:SingleLogoutService Binding="urn:oasis:names:tc:SAML:2.0:bindings:SOAP" Location="https://shibboleth-sp.com/Shibboleth.sso/SLO/SOAP"/>
    <md:SingleLogoutService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://shibboleth-sp.com/Shibboleth.sso/SLO/Redirect"/>
    <md:SingleLogoutService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://shibboleth-sp.com/Shibboleth.sso/SLO/POST"/>
    <md:SingleLogoutService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact" Location="https://shibboleth-sp.com/Shibboleth.sso/SLO/Artifact"/>
    <md:AssertionConsumerService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://shibboleth-sp.com/Shibboleth.sso/SAML2/POST" index="1"/>
    <md:AssertionConsumerService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST-SimpleSign" Location="https://shibboleth-sp.com/Shibboleth.sso/SAML2/POST-SimpleSign" index="2"/>
    <md:AssertionConsumerService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact" Location="https://shibboleth-sp.com/Shibboleth.sso/SAML2/Artifact" index="3"/>
    <md:AssertionConsumerService Binding="urn:oasis:names:tc:SAML:2.0:bindings:PAOS" Location="https://shibboleth-sp.com/Shibboleth.sso/SAML2/ECP" index="4"/>
  </md:SPSSODescriptor>

</md:EntityDescriptor>
```
