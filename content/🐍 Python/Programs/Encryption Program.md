---
title: Encryption Program
---

```python
import random
import string
chars = " " + string.punctuation + string.digits + string.ascii_letters
chars = list(chars)
key = chars.copy()
random.shuffle(key)

#Encription

plain_text = input("Enter a message to encrypt :")
cipher_text = ""

for letter in plain_text :
    index = chars.index(letter)
    cipher_text += key[index]
    
print("Encrypted Message is", cipher_text)

#Decryption Program
plain_text = input("Enter a message to decrypt :")
cipher_text = ""
for letter in plain_text :
    index = key.index(letter)
    cipher_text += chars[index]
    
print("Encrypted Message is", cipher_text)
```