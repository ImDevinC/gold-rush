cerbot:
	sudo cerbot certonly --manual --preferred-challenges dns -d "isitgoldrush.com,*.isitgoldrush.com"
	
copy-certs:
	sudo cat /etc/letsencrypt/live/isitgoldrush.com/cert.pem > /tmp/isitgoldrush-cert.pem
	sudo cat /etc/letsencrypt/live/isitgoldrush.com/privkey.pem > /tmp/isitgoldrush-privkey.pem
	sudo cat /etc/letsencrypt/live/isitgoldrush.com/chain.pem > /tmp/isitgoldrush-chain.pem

encrypt-certs:
	aws kms encrypt --key-id alias/gold-rush --plaintext fileb:///tmp/isitgoldrush-cert.pem --output text --query CiphertextBlob > /tmp/isitgoldrush-cert.kms
	aws kms encrypt --key-id alias/gold-rush --plaintext fileb:///tmp/isitgoldrush-privkey.pem --output text --query CiphertextBlob > /tmp/isitgoldrush-privkey.kms
	aws kms encrypt --key-id alias/gold-rush --plaintext fileb:///tmp/isitgoldrush-chain.pem --output text --query CiphertextBlob > /tmp/isitgoldrush-chain.kms

clean:
	rm -rf /tmp/isitgoldrush-cert.{pem,kms}
	rm -rf /tmp/isitgoldrush-chain.{pem,kms}
	rm -rf /tmp/isitgoldrush-privkey.{pem,kms}

certs: certbot copy-certs encrypt-certs