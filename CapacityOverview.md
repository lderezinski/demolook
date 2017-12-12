<form action="/dashboards/12" method="get">
<h2><center>Capacity Overview</center></h2>
<div style="display:flex">
  <label for="Environment" style="color:#AAA;font-size:0.8em">Environment</label>
  <div style="margin:0 1em">
  <input type="radio" name="Environment" value="SPC" checked> Samsung Private Cloud<br>
  <input type="radio" name="Environment" value="JPC"> Joyent Public Cloud<br>
  <input type="radio" name="Environment" value=""> All<br>
  </div>
  <div style="margin:0 1em">
    <input type="text" id="Datacenter" name="Datacenter" /><br />
    <label for="Datacenter" style="color:#AAA;font-size:0.8em">Datacenter</label>
  </div>
  <div style="margin:0 1em">
    <input type="date" id="Date" name="Date" /><br />
    <label for="Date" style="color:#AAA;font-size:0.8em">Date</label>
  </div>
  <div style="margin:0 1em">
   <input type="submit" value="Go" name="Go" style="height:2em" />
  </div>
</div>
