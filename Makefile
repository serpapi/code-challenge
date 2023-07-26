execute:
	poetry run execute -s files/van-gogh-paintings.html

test:
	poetry run pytest tests/*

style-check:
	yapf --diff -r .

style-fix:
	yapf -i -r .
