<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="ks_c_5601">
<link rel=StyleSheet type="text/css" href="../../../../samplecss.css">
<object id=tb_DataSet classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
<param name=DataIDvalue="Col_Group_SumControl_data.csv">
<param name=SortExprvalue="+Deptnm+Year">
<param name=SubsumExprvalue="total,9:Deptnm:Year">
</object>
</head>
<body>
<table frame=box width=456><tr><td>SubSum, SubMin, SubMax, SubAvg</td>
<td width=160>Grid ( Group )</td></tr></table><br>
<object id=tb_Grid classid=CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B
height=362 width=456>
<param name='DataID'value='tb_DataSet'>
<param name='Format'value='
<C>ID=Deptnmname="Dept"width=100suppress=2</C>
<C>ID=Yearname="Year"width=40suppress=1</C>
<C>ID=Levelname="Level"width=40Value={Level}Align=Center</C>
<C>Id=SubSumname="SubSum"width=60Value={SubSum(Amt1)}Align=RightBgColor=#99FFCC</C>
<C>Id=SubMinname="SubMin"width=60Value={SubMin(Amt2)}Align=RightBgColor=#CCCCFF</C>
<C>Id=SubMaxname="SubMax"width=60Value={SubMax(Amt3)}Align=RightBgColor=#FF9999</C>
<C>Id=SubAvgname="SubAvg"width=60Value={SubAvg(Amt4)}Align=RightBgColor=#CCFF99</C>'>
</object>
</body>
</html>

