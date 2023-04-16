# Rides
Note to reviewer: 
1. I rarely leave comments in Ruby code, using them sparingly to highlight code designed around particular business logic, or that need an explained engineering decision. However, since this is a project for an interview process, I included comments to communicate some of my decisions/thoughts while completing the project.
2. Since the directions mentioned reducing duplicate API calls, I took that also to mean that the time the call was made and getting current traffic conditions was out of scope for this project. If that is not the case or was to change, you could manage freshness of the data with re-processing by last process time, or a webhook to get notified of big traffic events in an area and reprocessing around the affected routes (perhaps just when called on), or a myriad other ways relating to the various business needs and contraints ($, speed, maintainability).
3. I left comments for other things to add such as error logging to Sentry & address validations that I felt were out of scope.  If they are not, and you would like me to set that up/add them, please let me know.


Table of contents
=================

<!--ts-->
   * [Project Specs](#specification)
      * [Project Definitions](#definitions)
   * [API Documentation](#documentation)
     * [Rides](#rides)
     * [Documentation Definitions](#definitions)
<!--te-->

## Specification:

Include the following entities: </br>

Build a RESTful API endpoint that returns a paginated JSON list of rides in descending score order for a given driver.
Calculate the score of a ride in $ per hour as: (ride earnings) / (commute duration + ride duration). Higher is better
Google Maps is expensive. Consider how you can reduce duplicate API calls. </br>

Include RSpec tests.

## Definitions:

* The driving distance between two addresses is the distance in miles that it would take to drive a reasonably efficient route between them. It is not the straight line distance. It can be calculated by using a routing service
* The driving duration between two addresses is the amount of time in hours it would take to drive the driving distance under realistic driving conditions. It can be calculated by using a routing service
* The commute distance for a ride is the driving distance from the driver’s home address to the start of the ride, in miles
* The commute duration for a ride is the amount of time it is expected to take to drive the commute distance, in hours.
* The ride distance for a ride is the driving distance from the start address of the ride to the destination address, in miles
* The ride duration for a ride is the amount of time it is expected to take to drive the ride distance, in hours
* The ride earnings is how much the driver earns by driving the ride. It takes into account both the amount of time the ride is expected to take and the distance. For the purposes of this exercise, it is calculated as: $12 + $1.50 per mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes

# Documentation
#  Rides

Get all of a driver's rides.

**URL** : `/rides/:driver_id`

**Method** : `GET`

**Auth required** : NO

**Permissions required** : None

## Parameters
### Filter
**keyword**: `filter` <br />
**optional**: true <br />
**default**: none and returns all of a driver's rides.  <br />
**value**: `score` 	: returns potential rides for a driver in descending score order. <br />

---
### Pagination
**keyword**: `page_limit` the number of items returned per page <br />
**optional**: true <br />
**default**: 10 <br />
**value**: `a positive Integer` 	  <br />

**keyword**: `page` the paginated page returned <br />
**optional**: true   <br />
**default**: 1 <br />
**value**: `a positive Integer` <br />

Example: 
Items 1, 2, 3, 4, and 5 are returned using pagination of `page` = 2 and `page_limit` = 2:
Items 3 and 4 are returned.

---


##  Success Response

**Code** : `200 OK`

**Content examples**

GET `/rides/1`

```json

[{  "id": 1,

	"driver_id": 1,

	"pick_up_at": "2023-04-13 09:46:51 UTC",

	"route": {

		"id": 1,

		"distance_miles": 6,

		"end_address": "307 Cliff Dr, Laguna Beach, CA 92651",

		"start_address": "33333 S. Pacific Coast Hwy. Dana Point, CA 92629",

		"time_minutes": 16
	}
},
{	"id": 2,

	"driver_id": 1,

	"pick_up_at": "2023-04-12 15:07:51 UTC",

	"route": {

		"id": 2,

		"distance_miles": 10,

		"end_address": "32 Pancake Blvd, Dana Point CA",

		"start_address": "6675 Camino Del Avion, Dana Point, CA",

		"time_minutes": 15
	}
}]

```
GET `/rides/1`
**filter**: `score`

```json

[{	"id": 5,

	"driver_id": null,

	"pick_up_at": "2023-04-17 00:00:00 UTC",

	"route": {

		"id": 1,

		"distance_miles": 6,

		"end_address": "307 Cliff Dr, Laguna Beach, CA 92651",

		"start_address": "33333 S. Pacific Coast Hwy. Dana Point, CA 92629",

		"time_minutes": 16
	}
}]

```

##  Notes

### Score Calculation
**score** = (ride earnings) / (commute duration + ride duration)<br />
**ride earnings** = $12 + $1.50 per mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes<br />

**commute duration** for a ride is the amount of time it is expected to take to drive the commute distance, in hours.<br />
  
**ride duration** for a ride is the amount of time it is expected to take to drive the ride distance, in hours<br />
    

