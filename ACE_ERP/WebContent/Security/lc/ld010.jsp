<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>�����������>����������Ȳ
* ���α׷� ID	: ld010.jsp
* �� �� �� ��	: ����������Ȳ
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.8.22
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
* �� �� �� ��	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>����������Ȳ</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
	gcem_yyyymmdd.text = gcurdate.substring(0,7) + "01";
	gcem_yyyymmdd2.text = gcurdate;
	
    fnInit();

    //txt_empno.value =gusrid;
	//txt_empnmk.value = gusrnm;		    
    
	fnSelect();
    
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){

		



}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

	 	var CAR_SHR = document.getElementById("cmbCAR_NO").value;
		
	 	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	 
																				     + ",v_staxdate="+gcem_yyyymmdd.text
																				     + ",v_etaxdate="+gcem_yyyymmdd2.text
																				     + ",v_carno=" + CAR_SHR; 																				     	 	
	 	//prompt(this, param);
	 	
    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Ld010",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    
    	tr_post(tr1);

}

/******************************************************************************
Description : ���
******************************************************************************/
function fnPrint() {

		var v_carno =  ds_default.namevalue(ds_default.rowposition,"CAR_NO");
		var v_pisym = ds_default.namevalue(ds_default.rowposition,"DRIVE_DT").substr(0,6);
		
	    var param = "proType=S"
										            		+ ",v_carno =" + v_carno	  
										            		+ ",v_pisym =" + v_pisym; 		    
	
    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Ld010",  "JSP(O:DS_PRINT=ds_print)",  param);
        
    	tr_post(tr1);	
	    
		//gcds_data01.namevalue(1,"DATE") = gcurdate;	
	
		//prompt(this, dsT_RP_REPORT.text);
	
		ReportID.Preview();

}





</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

<object  id=ds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>

</script>


<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>


		var sendParam	= new Array();
		var arrParam	= new Array();
		var arrResult	= new Array();
		var carno;
		var time = ds_default.NameValue(row, "FROM_TM");
		var status = ds_default.NameValue(row, "STATUS");
		
		var strURL;	
		var strPos;

		sendParam[0] = ds_default.NameValue(row, "DRIVE_DT"); 
		sendParam[1] = ds_default.NameValue(row, "CAR_NO_ORG"); 
		sendParam[2] = time; 	

		
		//alert(sendParam);
		
		strURL = "../../Security/lc/ld015.jsp";
		strPos = "dialogWidth:400px;dialogHeight:500px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,sendParam,strPos);
		
		ds_default.ClearAll();

		fnSelect();			
		
 </script>


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/print.gif"						style="cursor:hand" onclick="fnPrint()">&nbsp;			
			<img src="<%=dirPath%>/Sales/images/refer.gif"						style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>

<br>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>�Ⱓ</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					
					&nbsp;~
					
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	
	
		<td width="100px"   class="tab24" bgcolor="#eeeeee" align=center>����</td>
		<td width="500px" class="tab24"  >&nbsp;
                     <select id=cmbCAR_NO style="WIDTH:100" onChange="fnSelect();">
                        <option value="">��ü</option>                
                        <option value="S">��Ÿ����</option>                    
                        <option value="C">ī�Ϲ�</option>
                        <option value="A">�ƹ���</option>                        
                    </select>
		</td> 
	</tr>
</table>

<br>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  style="position:relative;left:0px;width:1000px; height:510px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_default">
					<param name="IndWidth"		 	value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 		value="true">
					<param name="Editable"		 		value="true"> 
					<param name=TitleHeight      		value="30">
                    <param name="SuppressOption"   value="1">						
					<param name="Format"	 	 		value=" 
					<C> name='NO'					id={currow}			HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center</C>
					<C> Name='����'		  			ID=CAR_NO 	  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 		align=center	 show=false</C>
					<C> Name='����'		  			ID=CAR_NO 	  		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center	 value={Decode(CAR_NO,'G1','�׷���','G2','�׷���','S','��Ÿ����','A','�ƹ���','C','ī�Ϲ�')} sort=true suppress=1</C>
 					<C> Name='����'		  			ID=DRIVE_DT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center	 mask ='XXXX-XX-XX' sort=true</C>
                    <C> Name='����'        			ID=FROM_TM	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=40 		align=center </C> 					
                    <C> Name='����'        			ID=TO_TM		 	HeadAlign=Center HeadBgColor=#B9D4DC Width=40 		align=center </C>
                    <C> Name='���(km)'        		ID=DRIVE_BEFORE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center </C> 					
                    <C> Name='����(km)'        		ID=DRIVE_AFTER 	HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center </C>
                    <C> Name='������'        		ID=DESTINATION 	HeadAlign=Center HeadBgColor=#B9D4DC Width=210 	align=center </C>                     
                    <C> Name='����'        			ID=REMARK 			HeadAlign=Center HeadBgColor=#B9D4DC Width=240 	align=center align = left</C>
					<C> Name='�����'      			ID=ENO_NO			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 		align=center show=false</C>                                         
					<C> Name='��û'      			ID=ENO_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=55 		align=center  sort=true </C> 
					<C> Name='����'      			ID=DRIVER_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55 		align=center  sort=true</C>  					                       					                    
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>

</table> 


</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### ������������ ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="ds_print">
	<PARAM NAME="DetailDataID"						VALUE="ds_print">	
	<PARAM NAME="PaperSize"							VALUE="A4">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 				VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="150">
	<PARAM NAME="Format" 							VALUE="
	

<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=785 ,face='Tahoma' ,size=10 ,penwidth=1
	<I>id='../../Common/img/2015slg.jpg' ,left=2474 ,top=3 ,right=2802 ,bottom=119</I>
	<L> left=34 ,top=130 ,right=2815 ,bottom=130 </L>
	<L> left=2011 ,top=132 ,right=2011 ,bottom=270 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='[������¿��� �����Ϻο� ���� ���� ����]<2016.4.1. ����>' ,left=34 ,top=66 ,right=765 ,bottom=124 ,align='left' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���θ�' ,left=2093 ,top=138 ,right=2350 ,bottom=196</T>
	<T>id='����ƻ�(��)' ,left=2500 ,top=135 ,right=2757 ,bottom=193</T>
	<L> left=2011 ,top=198 ,right=2818 ,bottom=198 </L>
	<T>id='����ڵ�Ϲ�ȣ' ,left=2045 ,top=206 ,right=2418 ,bottom=265</T>
	<T>id='221-81-13834' ,left=2479 ,top=204 ,right=2781 ,bottom=262</T>
	<T>id='������¿��� �����Ϻ�' ,left=722 ,top=146 ,right=1905 ,bottom=220 ,face='Tahoma' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=34 ,top=172 ,right=262 ,bottom=230</T>
	<C>id='DRIVE_YM', left=320, top=172, right=513, bottom=230</C>
	<L> left=273 ,top=130 ,right=273 ,bottom=270 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=553 ,top=130 ,right=553 ,bottom=270 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=34 ,top=267 ,right=2815 ,bottom=267 </L>
	<T>id='1. �⺻����' ,left=32 ,top=278 ,right=278 ,bottom=347 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2442 ,top=132 ,right=2442 ,bottom=267 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=34 ,top=503 ,right=1339 ,bottom=503 </L>
	<L> left=556 ,top=362 ,right=556 ,bottom=503 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=34 ,top=429 ,right=1339 ,bottom=429 </L>
	<C>id='CAR_NO', left=815, top=434, right=1169, bottom=492</C>
	<C>id='CAR_NM', left=64, top=434, right=516, bottom=492</C>
	<L> left=34 ,top=362 ,right=1339 ,bottom=362 </L>
	<T>id='�� ��' ,left=143 ,top=370 ,right=400 ,bottom=429</T>
	<T>id='2. ������ ������ ���' ,left=29 ,top=516 ,right=545 ,bottom=585 ,align='left' ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڵ�����Ϲ�ȣ' ,left=810 ,top=368 ,right=1191 ,bottom=426</T>
	<L> left=34 ,top=593 ,right=2815 ,bottom=593 </L>
	<L> left=310 ,top=659 ,right=2810 ,bottom=659 </L>
	<T>id='���� ����' ,left=1426 ,top=598 ,right=1826 ,bottom=656</T>
	<T>id='������ ��� �Ÿ�(Km)' ,left=1990 ,top=667 ,right=2402 ,bottom=714</T>
	<L> left=34 ,top=786 ,right=2815 ,bottom=786 </L>
	<T>id='������� �Ÿ�(Km)' ,left=1154 ,top=728 ,right=1476 ,bottom=775</T>
	<T>id='���� ��' ,left=1222 ,top=672 ,right=1386 ,bottom=720</T>
	<L> left=706 ,top=595 ,right=706 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1095 ,top=659 ,right=1095 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='����' ,left=577 ,top=699 ,right=683 ,bottom=757</T>
	<T>id='�����' ,left=455 ,top=598 ,right=561 ,bottom=656</T>
	<L> left=553 ,top=659 ,right=553 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='�μ�' ,left=376 ,top=693 ,right=482 ,bottom=751</T>
	<L> left=1516 ,top=661 ,right=1516 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1881 ,top=661 ,right=1881 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=2185 ,top=722 ,right=2185 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='�������' ,left=64 ,top=659 ,right=262 ,bottom=717</T>
	<T>id='���� ��' ,left=818 ,top=669 ,right=982 ,bottom=717</T>
	<T>id='������� �Ÿ�(Km)' ,left=749 ,top=728 ,right=1072 ,bottom=775</T>
	<T>id='���� �Ÿ�(Km)' ,left=1566 ,top=701 ,right=1839 ,bottom=749</T>
	<L> left=310 ,top=595 ,right=310 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='����ٿ�(Km)' ,left=1924 ,top=728 ,right=2172 ,bottom=775</T>
	<T>id='�Ϲݾ�����(Km)' ,left=2193 ,top=728 ,right=2466 ,bottom=775</T>
	<L> left=2474 ,top=659 ,right=2474 ,bottom=786 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1884 ,top=720 ,right=2477 ,bottom=720 </L>
	<T>id='���' ,left=2564 ,top=691 ,right=2728 ,bottom=749</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=65 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=310 ,top=0 ,right=310 ,bottom=65 </L>
	<L> left=553 ,top=0 ,right=553 ,bottom=65 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=706 ,top=0 ,right=706 ,bottom=65 </L>
	<L> left=1095 ,top=0 ,right=1095 ,bottom=65 </L>
	<L> left=1516 ,top=0 ,right=1516 ,bottom=65 </L>
	<L> left=1881 ,top=0 ,right=1881 ,bottom=65 </L>
	<L> left=2185 ,top=0 ,right=2185 ,bottom=65 </L>
	<L> left=2474 ,top=0 ,right=2474 ,bottom=65 </L>
	<L> left=34 ,top=65 ,right=2815 ,bottom=65 </L>
	<C>id='FOR_BIZ', left=2249, top=0, right=2424, bottom=65, align='right', face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FOR_CMMT', left=1958, top=0, right=2138, bottom=65, align='right', face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MILEAGE', left=1609, top=0, right=1794, bottom=65, face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DRIVE_BEFORE', left=736, top=0, right=1061, bottom=65, face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DRIVE_DT', left=85, top=0, right=251, bottom=65, face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM', left=347, top=0, right=532, bottom=65, face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DRIVE_AFTER', left=1156, top=0, right=1447, bottom=65, face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=566, top=0, right=691, bottom=65, face='Tahoma', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=200 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=706 ,top=0 ,right=706 ,bottom=127 </L>
	<L> left=706 ,top=61 ,right=2815 ,bottom=61 </L>
	<T>id='������� ������ �Ÿ�(Km)' ,left=1056 ,top=8 ,right=1572 ,bottom=56 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� ������ �Ÿ�(Km)' ,left=1929 ,top=8 ,right=2445 ,bottom=56 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(MILEAGE)}' ,left=1167 ,top=66 ,right=1378 ,bottom=122</S>
	<S>id='{Sum(MILEAGE)}' ,left=2066 ,top=66 ,right=2278 ,bottom=122</S>
	<T>id='����������' ,left=2519 ,top=0 ,right=2770 ,bottom=58</T>
	<T>id='100%' ,left=2566 ,top=64 ,right=2731 ,bottom=122</T>	
	
	<L> left=2474 ,top=0 ,right=2474 ,bottom=124 </L>
	<L> left=1881 ,top=0 ,right=1881 ,bottom=124 </L>
	<L> left=34 ,top=124 ,right=2815 ,bottom=124 </L>
	<T>id='�� �� �� �� �� �� ȸ ��' ,left=2379 ,top=130 ,right=2828 ,bottom=200 ,align='left' ,face='Tahoma' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Ehr/images/common/hd_ci_1.jpg' ,left=2280 ,top=130 ,right=2379 ,bottom=200</I>


</B>

">
</OBJECT>



