# Marps-Mars-navigation
The api we are using: https://api.nasa.gov/

<p>To obtain info about the rovers has been used you can use this endpoint: https://api.nasa.gov/mars-photos/api/v1/rovers?api_key=DEMO_APIKEY</p>
<p>To obtain info about a rover, his cams, how many photos he did and the time has been used you can use this endpoint: https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity?api_key=DEMO_APIKEY</p>
<p>To obtain info about photos a rover did, you can use this endpoint: https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?api_key=DEMO_APIKEY</p>
<p>Another keys you can use to filter the photos are the following:</p>
<ul>
  <li>sol=100 (marsian date)</li>
  <li>cam=fhaz (the cam type)</li>
  <li>page=2 (filter by page)</li>
  <li>earth=YYY-MM-DD (you can use the earth date as well)</li>
</ul>

<p>You can also search by mission manifests of an individual rover using this endpoint: https://api.nasa.gov/mars-photos/api/v1/manifests/opportunity?api_key=DEMO_APIKEY</p>
<p>Note: you can't use the keys above to filter manifests</p>

<h1>Mars Rover Photos</h1>
This API is designed to collect image data gathered by NASA's Curiosity, Opportunity, and Spirit rovers on Mars and make it more easily available to other developers, educators, and citizen scientists. This API is maintained by Chris Cerami.

Each rover has its own set of photos stored in the database, which can be queried separately. There are several possible queries that can be made against the API. Photos are organized by the sol (Martian rotation or day) on which they were taken, counting up from the rover's landing date. A photo taken on Curiosity's 1000th Martian sol exploring Mars, for example, will have a sol attribute of 1000. If instead you prefer to search by the Earth date on which a photo was taken, you can do that, too.

Along with querying by date, results can also be filtered by the camera with which it was taken and responses will be limited to 25 photos per call. Queries that should return more than 25 photos will be split onto several pages, which can be accessed by adding a 'page' param to the query.

Each camera has a unique function and perspective, and they are named as follows:

<h1>Rover Cameras</h1>
<table>
  <tr>
    <th>Abbreviation</th>
    <th>Camera</th>
    <th>Curiosity</th>
    <th>Opportunity</th>
    <th>Spirit</th>
  </tr>
  <tr>
    <th>FHAZ</th>
    <th>Front Hazard Avoidance Camera</th>
    <th>✔</th>
    <th>✔</th>
    <th>✔</th>
  </tr>
  <tr>
    <th>RHAZ</th>
    <th>Rear Hazard Avoidance Camera</th>
    <th>✔</th>
    <th>✔</th>
    <th>✔</th>
  </tr>
  <tr>
    <th>MAST</th>
    <th>Mast Camera</th>
    <th>✔</th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <th>CHEMCAM</th>
    <th>Chemistry and Camera Complex</th>
    <th>✔</th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <th>MAHLI</th>
    <th>Mars Hand Lens Imager</th>
    <th>✔</th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <th>MARDI</th>
    <th>Mars Descent Imager</th>
    <th>✔</th>
    <th></th>
    <th></th>
  </tr>
  <tr>
    <th>NAVCAM</th>
    <th>Navigation Camera</th>
    <th>✔</th>
    <th>✔</th>
    <th>✔</th>
  </tr>
  <tr>
    <th>PANCAM</th>
    <th>Panoramic Camera</th>
    <th></th>
    <th>✔</th>
    <th>✔</th>
  </tr>
  <tr>
    <th>MINITES</th>
    <th>Miniature Thermal Emission Spectrometer (Mini-TES)</th>
    <th></th>
    <th>✔</th>
    <th>✔</th>
  </tr>
</table>	

<h1>Querying by Martian sol</h1>
Parameter	Type	Default	Description
sol	int	none	sol (ranges from 0 to max found in endpoint)
camera	string	all	see table above for abbreviations
page	int	1	25 items per page returned
api_key	string	DEMO_KEY	api.nasa.gov key for expanded usage

<h1>Example queries</h1>
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY

https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY

https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DEMO_KEY

<h1>Querying by Earth date</h1>
Parameter	Type	Default	Description
earth_date	YYYY-MM-DD	none	corresponding date on earth for the given sol
camera	string	all	see table above for abbreviations
page	int	1	25 items per page returned
api_key	string	DEMO_KEY	api.nasa.gov key for expanded usage
<h1>Example query</h1>
https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY

<h1>Mission Manifest</h1>
A mission manifest is available for each Rover at /manifests/rover_name. This manifest will list details of the Rover's mission to help narrow down photo queries to the API. The information in the manifest includes:

<h1>Key	Description</h1>
name	Name of the Rover
landing_date	The Rover's landing date on Mars
launch_date	The Rover's launch date from Earth
status	The Rover's mission status
max_sol	The most recent Martian sol from which photos exist
max_date	The most recent Earth date from which photos exist
total_photos	Number of photos taken by that Rover
It also includes a list of objects under the "photos" key which are grouped by sol, and each of which contains:

<h1>Key	Description</h1>
sol	Martian sol of the Rover's mission
total_photos	Number of photos taken by that Rover on that sol
cameras	Cameras for which there are photos by that Rover on that sol
An example entry from a sol at /manifests/Curiosity might look like:

{sol: 0, total_photos: 3702, cameras: [ "CHEMCAM", "FHAZ", "MARDI", "RHAZ"]}

This would tell you that this rover, on sol 0, took 3702 photos, and those are from among the CHEMCAM, FHAZ, MARDI, and RHAZ cameras.
