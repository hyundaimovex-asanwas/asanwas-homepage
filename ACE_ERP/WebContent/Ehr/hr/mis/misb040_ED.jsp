<!--
***********************************************************************
* @source      : misb040_ED.jsp
* @description : 직위별 인원현황
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
String STR_YMD     = request.getParameter("STR_YMD").replaceAll("-","");
String STR_STD     = request.getParameter("STR_STD");
String STR_END     = request.getParameter("STR_END");

System.out.println(STR_YMD);
System.out.println(STR_STD);
System.out.println(STR_END);

String sql = XmlSqlUtils.getSQL("mis", "MISB040_SHR");

    Object[] bind = new Object[] {
            STR_YMD,
            //STR_STD,
            //STR_END,
            //STR_YMD.substring(0,4),
    };
    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
       String     colStr  =   "GUBUN,ENO_NO,MF_NM,REG_NM,'수도권',OCC_NM,JOB_NM,DPT_NM,ENO_NM,AGE,HIR_YMD,HIRG_YMD,JPR_YMD,DPA_YMD,TERM_YEAR,SCH_NM,MAJ_NM,GUR_YMD,GRD1_NM,GRD11,GRD12,GRD2_NM,GRD21,GRD22,GRD3_NM,GRD31,GRD32,GRD4_NM,GRD41,GRD42,GRD5_NM,GRD51,GRD52,H_NM,P_NM,MOVE_CNT";

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
