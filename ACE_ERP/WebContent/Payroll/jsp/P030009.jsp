<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<HTML>
<HEAD>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<TITLE>2010�� �ٷμҵ���� �Ű� �Է�</TITLE>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<SCRIPT language=JavaScript src="../html/imgs/web.js"></SCRIPT>
<SCRIPT language=JavaScript src="../html/imgs/06YearEntry.js"></SCRIPT>



<SCRIPT language=JavaScript>

//-->
</SCRIPT>
<LINK href="../html/css/hrms_year.css" type=text/css rel=stylesheet>
<LINK href="../html/css/css_ehr.css" type=text/css rel=stylesheet>
<script language="javascript">

get_cookdata();

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	//�����ڱ���
	gcds_manager.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s2?v_str1=2060&v_str2="+gusrid;
	//prompt('',gcds_manager.DataID)
	gcds_manager.Reset();	


	if(gcds_manager.countrow>0){ //������ ����

		//alert("������ ����?");
		entry.empno.value = '';
		entry.eyy.value="2010";


	}else{

		//alert("�Է±Ⱓ�� �������ϴ�. �Է��� ���Ͻø� �����ڿ��� �����Ͻʽÿ�.");
       //alert("2011�� 01�� 17�� ���� �Է� �����մϴ�.");
	  //return ;

		if(gusrid=="2010017"||gusrid=="2020008"||gusrid=="2050045"||gusrid=="4090009"||gusrid=="6060002") gusrid ="";

		entry.empno.value = gusrid;
		entry.eyy.value="2010";
		goYC();
	}
}

function goYC() {

  //�ӽø���.
	//if(gcds_manager.countrow>0){
	//}else{
	//  alert("�Է±Ⱓ�� �������ϴ�. �Է��� ���Ͻø� �����ڿ��� �����Ͻʽÿ�.");
    //alert("2009�� 01�� 12�� ���� �Է� �����մϴ�.");
	//  return ;
	//}

  if(gusrid ==entry.empno.value){
		if (!entry.empno.value){
			alert("����� �Է��� �ּ���.");
			entry.empno.focus();
			return;
		}
	}else{
		if(gcds_manager.countrow>0){
			
		}else{
			alert("���λ���� ��ȸ �����մϴ�.");
			return;
		}
	}
	dest = "/payroll/P030010.jsp?eyy="+ entry.eyy.value +"&eno=" + entry.empno.value;
	window.open(dest,"oops", "left=0,top=0,width=1024,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}


function goYC_temp() {
	dest = "/payroll/P030011.jsp?eyy="+ entry.eyy.value +"&eno=" + entry.empno2.value;
	window.open(dest,"oops", "left=0,top=0,width=1024,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );

}


</script>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ڱ��� -->
</OBJECT>

</HEAD>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<FORM name=entry action="" method=post>
	<INPUT type=hidden value=2007 name=eyy> 
<TABLE cellSpacing=0 cellPadding=0 width=854 border=0>
  <TR>
    <TD vAlign=top bgColor=#ffffff height=62><BR>���� �����Ű��� �ۼ��Ϸ��� ����� �Է��� �ۼ���ư�� �����ּ���.<BR><BR>
	��������� :  <input type=text name=empno size=8 class="input01" onkeydown="if (event.keyCode==13) goYC();"> 
	<input type=button value="�ۼ�" class=input02 style="cursor:hand" onclick=goYC();>
	</TD>
  </TR>





</TABLE>



</FORM>
</BODY>
</HTML>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	