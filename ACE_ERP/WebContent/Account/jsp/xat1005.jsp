<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ڵ���ǥ - POS ��Ȳ
+ ���α׷� ID	:  xat1005.jsp
+ �� �� �� ��	:  POS ��Ȳ   
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2018.04.30
+ �� �� �� ��	:  
+ ���콺 ����    :  5.2 
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� ��     :	         
+ ��   ��  ��      : 
+ �� �� �� ��     : 
+ �� �� �� ��     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>POS ���� ��Ȳ </title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�

var gs_upload_gb="";  //���� �׸��� ���ε�� �����ϱ� 


<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	
	//gcem_saledt_fr.text = "20180101";
	gcem_saledt_fr.text = gs_date;
	gcem_saledt_to.text = gs_date;
	
	gcrd_prt_gubun.codevalue ="1";
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){

}


<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(e){
	//data Recode 
    gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_s1?v_str1="+gcem_dfscost.text
    		                                                                  +"&v_str2="+gcem_saledt_fr.text
    		                                                                  +"&v_str3="+gcem_saledt_to.text;
    		                                                                  	
	gcds_excel_grid.Reset();
}



<%
/******************************************************************************************
	Description : ����
*****************************************************************************************/
%>
function ln_Delete(){

}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/





<%
/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
%>
function ln_Excel(){

	gcgd_disp01.GridToExcel("POS ������","",2);
}


<%//���� ã��   %>
function ln_Popup_DfsCost(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0] = "001"; //��������
	
	strURL = "./xat_dfscost_popup.jsp";
	strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	    gcem_dfscost.text    = arrParam[0];
	}else{
	    gcem_dfscost.text    = "";
	}
}




<%
/******************************************************************************
Description : ���ε������ �׸��� ������ ���� 
******************************************************************************/
%>
function fn_user_id(){
	
	for(var j=1;j<=gcds_excel_grid.countrow;j++){
		
		//�۾���  id ����		
		gcds_excel_grid.namevalue(j,"CREATE_ID") =gs_userid ;     
		
	}
	gs_upload_gb="";
}



<%
/******************************************************************************
	Description : ���  
******************************************************************************/
%>
function ln_Print(){
	
	  gcds_exchage.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1005_s3"
					     + "?v_str1="+gcem_dfscost.text    
					 	 + "&v_str2="+gcem_saledt_fr.text          
						 + "&v_str3="+gcem_saledt_to.text;   
	  gcds_exchage.Reset();
	
	  gcds_rptmst.clearAll();
	
	  if (gcds_rptmst.countrow<1){ 
        var s_temp = "SALEDT:STRING,WUSD:STRING,WCNY";
         gcds_rptmst.SetDataHeader(s_temp);
	  }
		
      // alert("irow:::"+irow+"::::"+gcds_code01.namevalue(irow,"PAYDAT"));  

      gcds_rptmst.addrow();
      gcds_rptmst.namevalue(gcds_rptmst.rowposition,"SALEDT") = gcem_saledt_fr.text;
      gcds_rptmst.namevalue(gcds_rptmst.rowposition,"WUSD") = gcds_exchage.namevalue(gcds_exchage.rowposition,"USDER");
      gcds_rptmst.namevalue(gcds_rptmst.rowposition,"WCNY") = gcds_exchage.namevalue(gcds_exchage.rowposition,"CNYER");
      
	
	
	  /*
	   var irow=0;
	   
	   _out:
	   for(var k=1;k<=gcds_code01.countrow;k++){
		   
		   if(gcds_code01.namevalue(k,"PAYDAT")!=""){
			   irow = k;
			   break _out;
		   }
	   } 

	  */
	  if(gcrd_prt_gubun.codevalue=="1"){   //��ü 
		  
			gcds_rptdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1005_s1"
							    + "?v_str1="+gcem_dfscost.text    
							 	+ "&v_str2="+gcem_saledt_fr.text          
								+ "&v_str3="+gcem_saledt_to.text;   
						    	    
			// prompt('', gcds_code01.DataID);				
			gcds_rptdtl.Reset();
			
			gcrp_print.Preview();
		  
		  
		  
		  

		    /* 
	        if (gcds_master.countrow<1){ 
	           var s_temp = "TITLE:STRING";
				gcds_master.SetDataHeader(s_temp);
			}	
	        // alert("irow:::"+irow+"::::"+gcds_code01.namevalue(irow,"PAYDAT"));  
	
	        gcds_master.addrow();
	        gcds_master.namevalue(gcds_master.rowposition,"TITLE") = "������޸��� ("
                                                                   +gcds_code01.namevalue(irow,"PAYDAT").substring(0,4)+"."
                                                                   +gcds_code01.namevalue(irow,"PAYDAT").substring(4,6)+"."
                                                                   +gcds_code01.namevalue(irow,"PAYDAT").substring(6,8)+")";
            if(gcrd_gubun.codevalue=="1"){ //���� 		                                                                                                     
				gcrp_print.Preview();
			}else if(gcrd_gubun.codevalue=="2"){//����
				gcrp_print2.Preview();
			}
            */
		}else{
			
			
			gcds_rptdtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1005_s2"
			    + "?v_str1="+gcem_dfscost.text    
			 	+ "&v_str2="+gcem_saledt_fr.text          
				+ "&v_str3="+gcem_saledt_to.text;   
		    	    
			// prompt('', gcds_code01.DataID);				
			gcds_rptdtl.Reset();
			
			gcrp_print2.Preview();
			
			
			/*
			//alert("������� ��¹��� �����ϴ�. ������ �̿��Ͻʽÿ�");
			 if (gcds_master.countrow<1){ 
		         var s_temp = "TITLE:STRING";
			     gcds_master.SetDataHeader(s_temp);
			 }
				
		       gcds_master.addrow();
		        gcds_master.namevalue(gcds_master.rowposition,"TITLE") = "������޸��� ("
                                                                       +gcds_code01.namevalue(irow,"PAYDAT").substring(0,4)+"."
                                                                       +gcds_code01.namevalue(irow,"PAYDAT").substring(4,6)+"."
                                                                       +gcds_code01.namevalue(irow,"PAYDAT").substring(6,8)+")";
            if(gcrd_gubun.codevalue=="1"){ //���� 		                                                                                                     
				gcrp_print3.Preview();
			}else if(gcrd_gubun.codevalue=="2"){//����
				gcrp_print3.Preview();
			}
            */
		}
}


<%
/******************************************************************************
	Description : ȯ�����  
******************************************************************************/
%>
function ln_Exchange(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0] = "001"; //��������
	
	strURL = "./xat_exchange_popup.jsp";
	strPos = "dialogWidth:550px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	    gcem_dfscost.text    = arrParam[0];
	}else{
	    gcem_dfscost.text    = "";
	}
	
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">


<!--����Ʈ -->
<object  id=gcds_rptmst classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_rptdtl classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--�������ε� �� �׸��� DATA -->
<object  id=gcds_excel_grid classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
	<param name=SortExpr	  value="+DFSCD+DFSNM+SALEDT+POSNO+RECNO">
	<param name=SubsumExpr	  value="'Total,1:SUBSUM">
</object>


<object  id=gcds_exchage classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">	
</object>


<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>




<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	//alert("gcds_excel_grid:row:"+row);
	if(gs_upload_gb=="1"){
		fn_user_id();
	}
	
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>

	if(row>0){ 
		if(colid=="EXRATE"){
			if(gcds_excel_grid.namevalue(row,"CURUNIT")!="WON"){
				gcgd_disp01.ColumnProp("EXRATE","Edit")="";
			}else{
				gcgd_disp01.ColumnProp("EXRATE","Edit")="none";
			}
		}
	}

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("������ ������ ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("������ ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	//ln_Upload_Grid();
	alert("���� ���ε� �غ� �Ϸ��Ͽ����ϴ�. [����]��ư�� �����Ͽ� ERP�� ���밡���մϴ�.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
		
		
		    <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/btn_exchange.gif"      style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Exchange()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"       style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Print()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:270px">
						<comment id="__NSID__">
						<object id=gcem_dfscost classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Enable          value=false>
							<param name=PromptChar	    value="_">
						</object>
					    </comment><script>__ws__(__NSID__);</script></nobr>&nbsp;
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_DfsCost()">
				    	
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:300px">
						<comment id="__NSID__">
							<object  id=gcem_saledt_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_saledt_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							~
							
							<object  id=gcem_saledt_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_saledt_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							</nobr>
					</td>
					
					<td class="tab12"  width="80px;"  bgcolor="#eeeeee" align=center>��±���</td> 
					<td class="tab23" >&nbsp;
						<comment id="__NSID__">
							<object id=gcrd_prt_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
								<param name=Cols	    value="2">
								<param name=Format	value="1^��ü ,2^ī��">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:597px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<FG> Name ='��������'     	            HeadAlign=Center HeadBgColor=#B9D4DC   
								<C> Name='LV'			ID=CurLevel		HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	    align=center   SumBgColor=#C3D0DB sumtext=''      sort=false   edit=none  Value={CurLevel} show=false</C>
								<FC> Name='�ڵ�'     	ID=DFSCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	    align=center	SumBgColor='#C3D0DB'  edit=none suppress=3</FC>
								<FC> Name='�����'     	ID=DFSNM        HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=center  	SumBgColor='#C3D0DB'  edit=none suppress=2   Value={Decode(CurLevel,1,'�Ұ�',0,DFSNM)} SumText='�հ�'</FC>
								<FC> Name='��������'	    ID=SALEDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  edit=none MASK ='XXXX/XX/XX' suppress=1</FC> 
								<FC> Name='����'     	ID=POSNO        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB'  edit=none Value={Decode(CurLevel,1,'�Ǽ�',0,POSNO)} SumText='�Ǽ�'</FC>
								<FC> Name='������'	    ID=RECNO  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none Value={Decode(CurLevel,1,SubCount(Level=0),0,RECNO)} SumText=@count</FC>
								</FG>
							    <C> Name='����1'	        ID=GUBUN  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none</C>	   
								<C> Name='����2'	        ID=GUBUN2  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none</C>
								<G> Name ='�ֹ��ð�'                      HeadAlign=Center HeadBgColor=#B9D4DC   
								<C> Name='����'	        ID=ORDTM  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='����'	        ID=APPTM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center 	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								<G> Name ='��ǰ����'                      HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ǰ�ڵ�'       ID=GOODCD	    HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='���ڵ�'	        ID=BARCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='��ǰ��'	        ID=GOODNM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
				                </G>
				                
				                <G> Name ='�Ǹ�����'                      HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'	    	ID=GOODCNT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���԰�'	        ID=BUYAMT  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�Ѹ����'       ID=TSALAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���ξ�'        ID=DISCAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���α���'      ID=DISGB  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80   	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='�Ǹ����'      ID=SALAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='����'         ID=PRIAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�ΰ���'        ID=VATAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='������'        ID=ADJAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�����հ�'      ID=APPSUM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='��ȭ'         ID=WONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�ſ�ī��'      ID=CARDAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���ݿ�ȭ'      ID=CASHAMT       HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='����'         ID=CNYAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���ȿ�ȭ'      ID=CWONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�޷�'         ID=USDAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�޷���ȭ'      ID=UWONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='����Ʈ'        ID=PNTAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='ī���ڵ�'	    ID=CARDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center  	SumBgColor='#C3D0DB'  edit=none	</C>
								<C> Name='ī���'	        ID=CARDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	
</table> 


<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>


<comment id="__NSID__">

<object id="gcrp_print" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"		value="gcds_rptmst">
	<param name="DetailDataID"		value="gcds_rptdtl">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"    value="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="SuppressColumns"	value="2:DFSNM;1:GB"> 
	<param name="Format"			value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=556 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1069 ,top=93 ,right=1897 ,bottom=233 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='����鼼�� ���� ����' ,left=1072 ,top=101 ,right=1894 ,bottom=230 ,face='HY�߰��' ,size=19 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='��  ��  ��  ��' ,left=64 ,top=492 ,right=339 ,bottom=545 ,align='left' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SALEDT', left=341, top=294, right=699, bottom=352, align='left' ,mask='XXXX-XX-XX', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='�Ǹ�ȯ��(��) :' ,left=71 ,top=357 ,right=336 ,bottom=410 ,align='left' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    ��    �� :' ,left=71 ,top=294 ,right=336 ,bottom=355 ,align='left' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1USD/' ,left=341 ,top=357 ,right=471 ,bottom=410 ,align='left' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WUSD', left=474, top=357, right=696, bottom=410, align='left' ,mask='X,XXX��', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='1CNY/' ,left=341 ,top=415 ,right=471 ,bottom=468 ,align='left' ,face='����' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WCNY', left=474, top=415, right=696, bottom=468, align='left' ,mask='XXX��', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=101 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=64 ,top=3 ,right=2765 ,bottom=3 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=79 ,top=19 ,right=460 ,bottom=79 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2765 ,top=5 ,right=2765 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2363 ,top=3 ,right=2363 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2037 ,top=3 ,right=2037 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1384 ,top=3 ,right=1384 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1058 ,top=3 ,right=1058 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=733 ,top=3 ,right=733 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=5 ,right=468 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=3 ,right=64 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1709 ,top=3 ,right=1709 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=484 ,top=19 ,right=725 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޷�(USD)' ,left=743 ,top=19 ,right=1050 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ȭ(CNY)' ,left=1069 ,top=19 ,right=1376 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȭ(WON)' ,left=1394 ,top=19 ,right=1701 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ī��' ,left=1720 ,top=19 ,right=2027 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����(WON)' ,left=2048 ,top=19 ,right=2355 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ�' ,left=2371 ,top=19 ,right=2752 ,bottom=82 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=101 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='DFSNM', left=77, top=21, right=460, bottom=85, supplevel=2, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=64 ,top=0 ,right=64 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=466 ,top=0 ,right=64 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=2 </L>
	<L> left=468 ,top=0 ,right=468 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=847 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=847 ,top=0 ,right=471 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=2363 ,top=0 ,right=2363 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2037 ,top=0 ,right=2037 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1709 ,top=0 ,right=1709 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1384 ,top=0 ,right=1384 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1058 ,top=0 ,right=1058 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=733 ,top=0 ,right=733 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='GB', left=484, top=21, right=725, bottom=85, supplevel=1, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='USD', left=743, top=21, right=1050, bottom=85, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CNY', left=1069, top=21, right=1376, bottom=85, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='UCWON', left=1394, top=21, right=1701, bottom=85, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CARD', left=1720, top=21, right=2027, bottom=85, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CASH', left=2048, top=21, right=2355, bottom=85, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='WONSUM', left=2371, top=21, right=2754, bottom=85, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=64 ,top=0 ,right=2765 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object>



<object id="gcrp_print2" classid="clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089"> 
	<param name="MasterDataID"		value="gcds_rptmst">
	<param name="DetailDataID"		value="gcds_rptdtl">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"    value="false">
	<PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="SuppressColumns"	value="2:DFSNM;1:GB"> 
	<param name="Format"			value="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=561 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=1069 ,top=93 ,right=1897 ,bottom=233 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�ſ�ī�� ����' ,left=1072 ,top=101 ,right=1894 ,bottom=230 ,face='Tahoma' ,size=19 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='��  ��  ��  ��' ,left=64 ,top=492 ,right=339 ,bottom=545 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SALEDT', left=341, top=294, right=699, bottom=352, align='left' ,mask='XXXX-XX-XX', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='�Ǹ�ȯ��(��) :' ,left=71 ,top=357 ,right=336 ,bottom=410 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    ��    �� :' ,left=71 ,top=294 ,right=336 ,bottom=355 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1USD/' ,left=341 ,top=357 ,right=471 ,bottom=410 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WUSD', left=474, top=357, right=696, bottom=410, align='left' ,mask='X,XXX��', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='1CNY/' ,left=341 ,top=415 ,right=471 ,bottom=468 ,align='left' ,face='Tahoma' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WCNY', left=474, top=415, right=696, bottom=468, align='left' ,mask='XXX��', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=100 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=64 ,top=3 ,right=2765 ,bottom=3 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ſ�ī��' ,left=79 ,top=19 ,right=460 ,bottom=79 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='û��' ,left=484 ,top=19 ,right=828 ,bottom=82 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=870 ,top=19 ,right=1214 ,bottom=82 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�鼼)' ,left=1630 ,top=19 ,right=1974 ,bottom=82 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ�' ,left=1995 ,top=19 ,right=2339 ,bottom=82 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=2371 ,top=19 ,right=2752 ,bottom=82 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȭ��' ,left=1251 ,top=19 ,right=1595 ,bottom=82 ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2765 ,top=5 ,right=2765 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2352 ,top=3 ,right=2352 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1984 ,top=3 ,right=1984 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1614 ,top=3 ,right=1614 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1230 ,top=3 ,right=1230 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=847 ,top=3 ,right=847 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=468 ,top=5 ,right=468 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=3 ,right=64 ,bottom=98 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=100 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='CARDNM', left=77, top=21, right=460, bottom=85, supplevel=2, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='DFSCD1', left=487, top=21, right=831, bottom=85, align='right', supplevel=1, face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='DFSCD2', left=873, top=21, right=1217, bottom=85, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='DFSCD3', left=1254, top=21, right=1598, bottom=85, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='DFSCD4', left=1630, top=21, right=1974, bottom=85, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CARDSUM', left=1995, top=21, right=2339, bottom=85, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=64 ,top=0 ,right=64 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=466 ,top=0 ,right=64 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=2 </L>
	<L> left=468 ,top=0 ,right=468 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=847 ,top=0 ,right=847 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1230 ,top=0 ,right=1230 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1614 ,top=0 ,right=1614 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1984 ,top=0 ,right=1984 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2352 ,top=0 ,right=2352 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=2765 ,bottom=101 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2765 ,top=0 ,right=847 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=847 ,top=0 ,right=471 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=64 ,top=0 ,right=2765 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object>
</comment><script>__ws__(__NSID__);</script> 


			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 