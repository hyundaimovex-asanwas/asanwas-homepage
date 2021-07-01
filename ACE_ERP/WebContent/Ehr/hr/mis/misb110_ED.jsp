<!--
***********************************************************************
* @source      : misb110_ED.jsp
* @description : 직무분석표
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15     방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
  elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
String STR_YMD        = request.getParameter("STR_YMD").replaceAll("-", "");
String DPT_CD_SHR     = request.getParameter("DPT_CD_SHR").replaceAll("-", "");

StringBuffer sb = new StringBuffer();

if (DPT_CD_SHR.length()>0){
    sb.append("AND A.DPT_CD = '" + DPT_CD_SHR + "' \n");
}


/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
Object[] sqlParam = new Object[] {
        sb.toString()
};

String sql = XmlSqlUtils.getSQL("mis", "MISB110_SHR");
sql = SqlUtils.replaceQuery(sql, sqlParam);

    Object[] bind = new Object[] {
            STR_YMD,
            STR_YMD,
            STR_YMD
    };
    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
       String     colStr  =   "HIR_YMD,RET_YMD,DPT_NM,ENO_NO,ENO_NM,JOB_NM,TOT_MONTH,DIFF_NM,EDGR_NM,JIKMU_NM";

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
           hnwExtQuery.EndData(response);

%>
