<!--
***********************************************************************
* @source      : misb110_ED.jsp
* @description : ���κ����
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15     �漮ȣ        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
  elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.support.vo.* "%>
<%@page import ="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import ="com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
String STR_YMD 	   = request.getParameter("STR_YMD").replaceAll("-", "");
String DPT_CD_SHR  = request.getParameter("DPT_CD_SHR").replaceAll("-", "");

StringBuffer sb = new StringBuffer();

if (DPT_CD_SHR.length()>0){
	sb.append("AND A.DPT_CD = '" + DPT_CD_SHR + "' \n");
}


/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
Object[] sqlParam = new Object[] {
		sb.toString()
};

String sql = XmlSqlUtils.getSQL("mis", "MISB120_SHR");
sql = SqlUtils.replaceQuery(sql, sqlParam);

	Object[] bind = new Object[] {
			STR_YMD
	};
	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** �ʵ尪 ���� **/
   	String 	colStr  =   "GBN_NM,ENO_NM,HIR_YMD,RET_YMD,DPT_NM,JOB_NM,ENO_NO,EDGR_NM,MF_NM,JIKMU_NM";

   	String[] values = colStr.split(",");
   	for( int x = 0; x < values.length; x++ ){
   		hnwExtQuery.AddField(values[x]);
   	}
    hnwExtQuery.SendField(response);

       if (voList.size() > 0)
       {
           for (int i=0; i<voList.size(); i++)
           {
               DynamicValueObject vo = (DynamicValueObject)voList.get(i);

           	for( int x = 0; x < values.length; x++ ){
                   hnwExtQuery.AddData(vo.getString(values[x]));
           	}
               hnwExtQuery.SendData(response);
           }
       }
       else
       {
       	// hnwExtQuery.AddData("�����Ͱ� �������� �ʽ��ϴ�.");
       	for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
       	}
           hnwExtQuery.SendData(response);

       }

%>
