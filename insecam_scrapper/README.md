### Insecam Scrapper

to install dependencies run:

`pip install -r requirements.txt`

to run the scrapper:

`python insecam_scrap.py <name for stream> <insecam livestream url> <frequency> <limit>`

or 

`python insecam_scrap.py -h`

for help

right click on stream and open image in new tab for the url. ^C to stop the download loop

### Using on EC2

temporary workflow:

scp scrapper files to instance:

`scp -i <permission file> -r <insecam folder> ec2-user@<instance address>:~`

ssh to instance:
`ssh -i <permission file> ec2-user@<instance address>`

get pip:

`curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py`

`python get-pip.py --user`

install dependencies to user:

`pip install --user -r requirements.txt`

run insecam_scrapper

# Memory Usage

~400KB per image

Lets say 1 image every 20 seconds for 10 hours on a camera = 1800 images, which ends up being around 720 MB

For 5 livestreams -> 3500MB -> just round up to around 4GB

4GB will fit under free tier for s3, but even without free tier, cost is literally pennies: 0.023$/GB * 4GB = 10 cents a month

PUT and GET requests should not be problems. We will tar screencap folders before sending to S3. Requests should be drastically lower than the 20k GETs and 2k PUTS in the free tier. Even beyond that, costs will be pennies.






