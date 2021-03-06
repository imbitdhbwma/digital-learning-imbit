# Open Badges Technical Documentation

## Description

Open Badges are verifiable, portable digital badges with embedded metadata about skills and achievements. They comply with the Open Badges Specification and are shareable across the web. Each Open Badge is associated with an image and information about the badge, its recipient, the issuer, and any supporting evidence. All this information may be packaged within a badge image file. [ELI5 Open Badge](https://openbadges.org/get-started/)

For brillianICM, a badge is earned after completion of any of the countries. If a user is assigned to a group that has badge sending allowed he can send it to his email with a button on the result page. A lecturer can send them at any time via the lecturer page.

### Useful links:

- Developer Information	https://openbadges.org/developers
- Issuer Information https://github.com/mozilla/openbadges-backpack/wiki/Open-Badges-Onboarding:-Issuers
- Assertion Information	https://github.com/mozilla/openbadges-backpack/wiki/assertion-information-for-the-uninitiated
- Badge Baking https://github.com/mozilla/openbadges-backpack/wiki/badge-baking
- Earn Example Badge	http://toolness.github.io/hackasaurus-parable/navigator-badge 
- OpenBadges Validator	https://badgecheck.io & http://validator.openbadges.org 
- JSON Web Signature (JWS) with RSA https://connect2id.com/products/nimbus-jose-jwt/examples/jws-with-rsa-signature
- JWS Verifier	http://kjur.github.io/jsjws/tool_verifyanalyze.html

It is recommended to read or at least skim through the first four links before continuing with this documentation.

### Used classes/files:

- MailClient.java
- sendCertificate.java
- PDFCreator.java
- Event.java
- JSONCreator.java
- UserRealm.java
- BadgeBakery.java
- login.jsp
- result.jsp
- pom.xml
- createDBbrillianICM.sql
- badgeAbout.html
- badgeCriteriaTable.html
- gridOBall_Table.css

---
- the badge .svg-files are located at brillianICM/WebContent/img/badges/
- link to public key http://ec2-52-14-250-138.us-east-2.compute.amazonaws.com:8080/brillianICM/badges/public-key-badges.pem 

## How does it work?

- The assertion (metadata) is "baked" into a .svg-file as a JWS (JSON Web Signature)

1. result.jsp -> press on button "send certificate and badge" to start the process => sendCertificate.java => MailClient.java -> sendCertificateMail() -> constructs the .svg-file thusly:
2. BadgeBakery.java -> bakeBadge(): This Method reads the .svg-file on the server in a buffered reader and inserts the assertion data into it after signing it.
  - Assertion data: JSONCreator.java -> createAssertion() -> creates the assertion data as a JSON and returns it as a String. Therefore, the user specific data gets extracted from the database (userRealm.java -> getBadgeAssertionID() bzw. newBadge()).
  
Example:
```
{"uid":"19","recipient":"student@dhbw-mannheim.de","issuedOn":"2018-03-06","badge":{"name":"brillianICM Sweden","image":"http//:link_image_sweden","description":"Successful completion of the ICM Sweden serious game","criteria":"http//:link_criteria_page","issuer":{"name":"DHBW Mannheim Studiengang IMBIT","org":"DHBW Mannheim","description":"Duale Hochschule Baden-Württemberg Studiengang International Management for Business and Information Technology","url":"http://www.imbit.dhbw-mannheim.de/"}},"verify":{"url":"","type":"signed"}}
```

  - Signing: BadgeBakery.java -> signBadge(): takes the JSON and encodes it with RSA-Encryption. Therefore a private key and a public key are hosted as .der/.pem-files. It is now a JWS(JSON Web Signature).
  
Example:
  ```
  eyJhbGciOiJSUzI1NiJ9.SW4gUlNBIHdlIHRydXN0IQ.IRMQENi4nJyp4er2LmZq3ivwoAjqa1uUkSBKFIX7ATndFF5ivnokXZc8u0A
  ```
 3. MailClient.java -> sendCertificateMail(): constructs the rest of the e-mail and sends it.
 

## How to test?

- For the development setup you need locally to develop and test on your computer see: [DevSetupGuide](https://github.com/MariaBiosciences/digital-learning-imbit/tree/master/resources/documentation/DevelopmentSetupGuide.md)


- You can set the user progress near to the end of a game to avoid playing trough it several minutes every time you want to test something. This is for 'brillianICM Sweden'.

#### Connect to the MySQL database and execute the following statements:

! Attention ! This is for the user with the ID '20', if you want to set it for another user, change the delete-statement and the 20 in the brackets in the insert-statement. On some systems the ' near the beginning and end of the statement cause an error. Try replacing them with other apostrophes.

```
use icmcake;
delete from user_progress where user_id=20;
insert into user_progress values (20,100,100,100,'l000e000;l500e001;l501e001;l501e002;l501e003;l501e004;l510e000;l520e000;l520e001;l520e004;l520e006;l520e008;l520e009;l520e012;l520e013;l520e015;l523e000;l523e001;l523e002;l523e004;l523e005;l523e008;l526e000;l526e002;l526e004;l526e006;l528e000;l528e002;l528e003;l528e004;l528e005;l528e006;l530e000;l530e901;l530e902;l530e903;l530e905;l533e000;l533e002;l533e004;l535e000;l535e001;l535e003;l535e903;l535e905;l535e909;l537e900;l537e901;l561e000;l561e001;l561e002;l561e003;l561e004;l561e005;l561e006;l561e007;l561e008;l561e009;l565e000;l565e001;l565e003;l565e005;l565e008;l565e010;l565e011;l565e012;l565e014;l565e016;l565e019;l565e020;l570e000;l570e002;l570e003;l570e004;l590e000;l590e001;l200e001;l700e001;l700e006;l700e011;l700e001;l700e006;l700e011;l500e001;l501e001;l501e002;l501e003;l501e004;l510e000;l520e000;l520e001;l520e004;l520e006;l520e008;l520e009;l520e012;l520e013;l520e016;l523e000;l523e001;l523e002;l523e004;l523e006;l523e008;l526e000;l526e003;l526e004;l526e006;l528e000;l528e001;l528e003;l528e004;l528e005;l528e006;l530e000;l530e001;l530e002;l530e003;l530e005;l530e904;l530e905;l533e000;l533e002;l533e004;l535e000;l535e001;l535e003;l535e005;l535e006;l535e907;l535e908;l535e909;l537e900;l537e901;l561e000;l561e001;l561e002;l561e003;l561e004;l561e005;l561e006;l561e007;l561e008;l561e009;l565e000;l565e002;l565e003;l565e004;l565e007;l565e010;l565e011;l565e012;l565e013;l565e016;l565e019;l565e020;l570e000;l570e002;l570e003;l570e005;l590e000',0,0,0,0,0,0,0);
```
