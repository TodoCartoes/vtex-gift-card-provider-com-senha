# CONSOLE PARA TESTAR O DECRYPT

require 'openssl'
require 'base64'

message  = 'bt3+BWbEm6Kx5oXjsg6cYMeoeqnucaJi45UhaWRHigfzxZMZdc861AQo93WudXuwIVFua4/5Ittdmn2RJiRZNQm3MLa2UqUP9kEd8Eo5lUCf/M7FexHKknAqYGzHF7ZpDaf1Xz6O73s58zbaZMXr8SR2MBZ9IwutZuXrhz4Hroe7DpKFgDqoEgjJp2Jf8DD8eL59QQraZLPVq94REWkLaPD5Ko0Oif76eeMQTwPQVXz5gnBc5jEZrG9PWBR3Z/hhz832FoSjlzO+/Y6fEATilIRvD3OlFTLp/P8CKbOmryEn1P1eECmNA526cH8cxtXdmqnd/hixd/nF5/+T3MhDhg==' # <<== Colocar a mensagem criptografada no frontend aqui
password = 'ac7d45b46dd1dd03dbd20ddb03c98d9f'
key_file = File.read 'private.pem'
key      = OpenSSL::PKey::RSA.new key_file, password
encrypted_massage = Base64.decode64 message
result = key.private_decrypt encrypted_massage
p result
p message.size