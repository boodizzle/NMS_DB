# Note: change this to obtain your chart data from some external source
data = [{
    value: rand(20),
    color: "#F7464A",
    highlight: "#FF5A5E",
    label: "January",
  }, {
    value: rand(30),
    color: "#46BFBD",
    highlight: "#5AD3D1",
    label: "February",
  }, {
    value: rand(30),
    color: "#FDB45C",
    highlight: "#FFC870",
    label: "March",
  }, {
    value: rand(30),
    color: "#949FB1",
    highlight: "#A8B3C5",
    label: "April",
  }, {
    value: rand(30),
    color: "#4D5360",
    highlight: "#4D5360",
    label: "April",
  }
]
options = { segmentStrokeColor: '#333' }

send_event('piechart', { segments: data, options: options })