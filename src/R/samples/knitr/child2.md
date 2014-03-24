<h1>Playing with HTML Table Templates</h1>

<style type="text/css">
 
        /*** central column on page ***/
        div#divContainer
        {
            max-width: 800px;
            margin: 0 auto;
            font-family: Lato;
            padding: 0.5em 1em 1em 1em;
 
            /* rounded corners */
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border-radius: 10px;
 
            /* add gradient */
            background-color: #808080;
            background: -webkit-gradient(linear, left top, left bottom, from(#606060), to(#808080));
            background: -moz-linear-gradient(top, #606060, #808080);
 
            /* add box shadows */
            -moz-box-shadow: 5px 5px 10px rgba(0,0,0,0.3);
            -webkit-box-shadow: 5px 5px 10px rgba(0,0,0,0.3);
            box-shadow: 5px 5px 10px rgba(0,0,0,0.3);
        }
 
        h1 {color:#FFFFFF; font-size:1.5em;}
 
        /*** sample table to demonstrate CSS3 formatting ***/
        table.formatHTML5 {
            width: 100%;
            border-collapse:collapse;
            text-align:left;
            color: #606060;
        }
 
        /*** table's thead section, head row style ***/
        table.formatHTML5 thead tr td  {
            background-color: White;
            vertical-align:middle;
            padding: 0.6em;
            font-size:0.8em;
        }
 
        /*** table's thead section, coulmns header style ***/
        table.formatHTML5 thead tr th
        {
            padding: 0.5em;
            /* add gradient */
            background-color: #003366;
            background: -webkit-gradient(linear, left top, left bottom, from(#003366), to(#003366));
            background: -moz-linear-gradient(top, #003366, #003366);
            color: #dadada;
        }
 
        /*** table's tbody section, odd rows style ***/
        table.formatHTML5 tbody tr:nth-child(odd) {
           background-color: #fafafa;
        }
 
        /*** hover effect to table's tbody odd rows ***/
        table.formatHTML5 tbody tr:nth-child(odd):hover
        {
            cursor:pointer;
            /* add gradient */
            background-color: #808080;
            background: -webkit-gradient(linear, left top, left bottom, from(#606060), to(#909090));
            background: -moz-linear-gradient(top, #606060, #909090);
            color: #dadada;
        }
 
        /*** table's tbody section, even rows style ***/
        table.formatHTML5 tbody tr:nth-child(even) {
            background-color: #efefef;
        }
 
        /*** hover effect to apply to table's tbody section, even rows ***/
        table.formatHTML5 tbody tr:nth-child(even):hover
        {
            cursor:pointer;
            /* add gradient */
            background-color: #808080;
            background: -webkit-gradient(linear, left top, left bottom, from(#606060), to(#909090));
            background: -moz-linear-gradient(top, #606060, #909090);
            color: #dadada;
        }
 
       /*** table's tbody section, last row style ***/
        table.formatHTML5 tbody tr:last-child {
             border-bottom: solid 1px #404040;
        }
 
        /*** table's tbody section, separator row pseudo-class ***/
        table.formatHTML5 tbody tr.separator {
            /* add gradient */
            background-color: #739FCC;
            background: -webkit-gradient(linear, left top, left bottom, from(#739FCC), to(#739FCC));
            background: -moz-linear-gradient(top, #739FCC, #739FCC);
            color: #dadada;
        }
 
        /*** table's td element, all section ***/
        table.formatHTML5 td {
           vertical-align:middle;
           padding: 0.5em;
        }
 
        /*** table's tfoot section ***/
        table.formatHTML5 tfoot{
            text-align:center;
            color:#303030;
            text-shadow: 0 1px 1px rgba(255,255,255,0.3);
        }
    </style>

<table class="formatHTML5">
<thead>
  <tr>
    <th align="right">Period<br />Start Date:<br />End Date:</th>
    <th align="center">1 Year Total<br /><%= format(one_year_ago, "%m/%d/%y") %><br /><%= format(end_date, "%m/%d/%y") %></th>
    <th align="center">6 Month Weekly Avg<br /><%= format(six_months_ago, "%m/%d/%Y") %><br /><%= format(end_date, "%m/%d/%Y") %></th>
    <th align="center">4 Week Avg<br /><%= format(four_weeks_ago, "%m/%d/%Y") %><br /><%= format(end_date, "%m/%d/%Y") %></th>
    <th align="center">Week<br /><%= format(two_weeks_ago, "%m/%d/%Y") %><br /><%= format(two_to_one_weeks_ago, "%m/%d/%Y") %></th>
    <th align="center">Week<br /><%= format(one_week_ago, "%m/%d/%Y") %><br /><%= format(end_date, "%m/%d/%Y") %></th>
  </tr>
</thead>
<tr class="separator">
  <td colspan="6">Overall</td>
</tr>
</table>
