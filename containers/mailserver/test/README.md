Create a `testmail.txt` file by copying `testmail.txt.template`. Just change `rcpt to: `

Then test like this:

	>docker build --rm -t testpostfix .
	>docker run --rm testpostfix
