jenkinsURL = 'http://your-jenkins-server/'
jobs = []
adInterval = 7000

$(document).ready ->
  fetchMainlineJobs()

fetchMainlineJobs = ->

  $.ajax {
    url: jenkinsURL + 'api/json',
    dataType: 'jsonp',
    jsonp: 'jsonp',
    async: false,
    success: (data) ->
      jobs = data.jobs
      showJobs()
    }

showJobs = ->
  $('#job-info').empty()
  $('#all-jobs').html('<ul></ul>')
  for job in jobs
    $('#job-info').append "<h1 style=\"display: none;\" class=\"#{job.color}\">#{job.name}</h1>"
    $('#all-jobs ul').append "<li class=\"#{job.color}\">#{job.name}</li>"
  flip()
  setTimeout (-> fetchMainlineJobs()), adInterval * jobs.length

flip = ->
  for index in [0...jobs.length]
    do (index) ->
      setTimeout (->
        $($("#job-info h1")[index])
          .fadeIn(adInterval*0.15)
          .delay(adInterval*0.70)
          .fadeOut(adInterval*0.15)), adInterval * index
