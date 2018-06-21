##Cryptonita

This is a simple sandbox to test encrypt decrypt strategy with JS at the frontend and Ruby at the backend. A `index.html` page with a Github.io is offered to clients in order to show what we can do in terms of crypt/decrypt!

### Smaller Encrypted Message Problem

To create a smaller encrypted message you need to generate a private key with less num bits.
In [JSEncrypt](https://github.com/travist/jsencrypt) doc, when you have to run:
```
openssl genrsa -out rsa_1024_priv.pem 1024

```
You can choose a smaller number of bits. In the case above, we are using the rocommended size 1024.
Using a 1024 priv key, your encrypted message have the size of 172 chars.
When using a 256 priv key, your encrypted message have the size of 44 chars.
This could generate a more 'easy' to decode message, but solves the database field size problem.
