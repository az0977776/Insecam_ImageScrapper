### Insecam Scrapper

to install dependencies run:

`pip install -r requirements.txt`

to run the scrapper:

`python insecam_scrap.py <insecam livestream url> <frequency>`

or 

`python insecam_scrap.py -h`

for help

right click on stream and open image in new tab for the url. ^C to stop the download loop

### Using on EC2

temporary workflow:

scp scrapper files to instance:
`scp -i <permission file> ec2-user@<instance address>:~`

get pip:
`curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py`
`python get-pip.py`

install dependencies to user:
`pip install --user -r requirements.txt`

need this version of opencv:
`pip install opencv-python-headless --user`

run insecam_scrapper
