<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ��� - �ڱ�������Ȳ
+ ���α׷� ID	:  a300070.jsp
+ �� �� �� ��	:  ������ �ʿ��� �ڱ��� ��û��Ȳ�� ��ȸ�ϴ� ȭ���̴�.  
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2016.12.19
+ �� �� �� ��	:  
+ ���콺 ����    :  5.2 
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
<title>�ڱ�������Ȳ</title>

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


<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){

	gcem_appdate_fr.text = gs_date;
	gcem_appdate_to.text = gs_date;
	//gcem_appdate.text = "20161001";
	//gcem_reqdate.text = gs_date;
	
	
	gcds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
	
	gclx_paygb.index =0;
	gclx_fsstat.index=0;
}

<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(e){
	
	 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a300070_s1?v_str1="+gclx_fdcode.bindcolval
	  																       +"&v_str2="+gcem_appdate_fr.text
	  																       +"&v_str3="+gcem_appdate_to.text
																		   +"&v_str4="+gcem_reqdate.text
																		   +"&v_str5="+gclx_paygb.bindcolval
																		   +"&v_str6="+gclx_fsstat.bindcolval
																		   +"&v_str7="+gcem_appempno.text;	
     gcds_data01.Reset();

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
	//gcgd_disp01.GridToExcel("���ں� �������� ��Ȳ","",2);
}

<%
/******************************************************************************
Description : ã�� - �ۼ��� 
******************************************************************************/
%>
function ln_Popup_Appempno(){

	if(gusrid=="6070001"||gusrid=="3170009"){
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		strURL = "./empno_popup.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_appempno.text    = arrParam[1];
			gcem_appempnm.text    = arrParam[0];
		}else{
			gcem_appempno.text="";
			gcem_appempnm.text="";
		}
	}
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--�ڱݽ�û���� -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=gcds_fdcode classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>




</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
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
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:0 solid #708090'>
				<tr>
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>����</nobr></td>
					<td class="tab24" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_fdcode    classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID      value="gcds_fdcode">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>��û��</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_appdate_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_appdate_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						~
						<comment id="__NSID__">
							<object  id=gcem_appdate_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_appdate_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>���޿�û��</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_reqdate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
			    </tr>
				<tr>
					<td class="tab27" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>���޻���</nobr></td>
					<td class="tab28" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_paygb classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			 value="^��ü,1^������,2^����,3^����">
								<param name=CBDataColumns	 value="CODE,NAME">
								<param name=SearchColumn	 value=NAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="NAME">								
								<param name=BindColumn		 value="CODE">
						    </object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab28" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>������ǥ����</nobr></td>
					<td class="tab28">
						<comment id="__NSID__">
							<object  id=gclx_fsstat classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			 value="^��ü,Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
								<param name=CBDataColumns	 value="CODE,NAME">
								<param name=SearchColumn	 value=NAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="NAME">								
								<param name=BindColumn		 value="CODE">
						    </object>
						</comment><script>__ws__(__NSID__);</script>		
					</td>
					<td class="tab28" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>ó����</nobr></td>
					<td class="tab28" >
						<comment id="__NSID__">
						<object id=gcem_appempno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Appempno()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_appempnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Enable		  value="false">
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:465px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<param name="GTitleHeight"  value=25>
							<param name="TitleHeight"   value="25">
							<param name=RowHeight       value="20">
							<PARAM NAME="Format"        VALUE="  
			
								<FC> Name='��û����'     ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' </FC>
								<FG> Name='��������'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='����'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:��������,2:��������,3:�ڵ����,4:���γ���'</FC>
								<FC> Name='��û��'     ID=REQDATE	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX'</FC>    
								<FC> Name='�Ϸ���'     ID=PAYDATE	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' </FC>
								</FG>    
								<FG> Name='�ŷ�ó����'   HeadAlign=Center HeadBgColor=#B9D4DC
								<FC> Name='�ڵ�'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none show=false </FC>
								<FC> Name='�ŷ�ó��'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='���¹�ȣ'    ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=120    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </FC>
								</FG>
								<C> Name='����'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='���ް���'    ID=SUPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none SumText=@sum  show=false</C>
								<C> Name='�ΰ�����'    ID=SUPVATAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none SumText=@sum  show=false</C>
								<C> Name='��û�ݾ�'    ID=APPAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none SumText=@sum  </C>
								<C> Name='���ޱ���'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:���뿹��,2:����,3:��ȭ���뿹��,4:����(��ȭ)'</C>
								
								<G> Name='��ȭ����'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ȭ��'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='��ȭ'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='ȯ��'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								
								<G> Name='��������'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ڵ�'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  show=false</C>
								<C> Name='������'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								<G> Name='����/��������' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'	     ID=COSTGB  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:����,2:����'</C>
								<C> Name='�ڵ�'	     ID=COSTBGT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none show=false</C>
								<C> Name='����/�����'	 ID=COSTBGTNM  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								
								<C> Name='�ڵ�'	     ID=ATCODE2 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none show=false</C>
								<C> Name='���ް�����'	 ID=ATKORNAM2	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	    align=left  	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none </C>
								
								<G> Name='��������'    HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����ó��'    ID=PURGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=53    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  EditStyle=CheckBox   show = false </C>
								<C> Name='��꼭��ȣ'   ID=TAXNBR 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none MASK='XXXXXXX-XXXX' show=false</C>
								</G>
								<G> Name='��û��ǥ����'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��������'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  show=false</C>
								<C> Name='������ȣ'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  show=false</C>
							    </G>
								<C> Name='���޻���'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:������,2:����,3:����' </C>
								<G> Name='��û��ǥ����'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��������'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=65    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  </C>
								<C> Name='������ȣ'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  </C>
								<C> Name='��ǥ��ȣ'    ID=SSLIPNO  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  </C>
							    <C> Name='��ǥ����'    ID=FSSTAT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='Y:����Ϸ�,R:�����û,N:������,C:�������,B:�ݼ�' </C>
							    <C> Name='�ڱݻ���'    ID=FSLOCK  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	BgColor={IF(FSLOCK='T','#FFCC66','FFFFFF')} SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='T:���' </C>
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
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
