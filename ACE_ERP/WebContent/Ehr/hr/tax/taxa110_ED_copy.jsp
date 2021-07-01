<!--
***********************************************************************
* @source      : taxa110_ED.jsp
* @description : 사업소세(종업원할)산출내역 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/04      이승욱        최초작성.        
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
    String HEAD_TAG       = request.getParameter("HEAD_TAG");
    String PIS_YY_A0      = request.getParameter("PIS_YY_A0");
    String PIS_MM_A0      = request.getParameter("PIS_MM_A0");
    String PIS_YY_A1F     = request.getParameter("PIS_YY_A1F");
    String PIS_MM_A1F     = request.getParameter("PIS_MM_A1F");
    String PIS_YY_A1T     = request.getParameter("PIS_YY_A1T");
    String PIS_MM_A1T     = request.getParameter("PIS_MM_A1T");
    String PIS_YY_M0      = request.getParameter("PIS_YY_M0");
    String PIS_MM_M0      = request.getParameter("PIS_MM_M0");
    String PIS_YY_M1F     = request.getParameter("PIS_YY_M1F");
    String PIS_MM_M1F     = request.getParameter("PIS_MM_M1F");
    String PIS_YY_M1T     = request.getParameter("PIS_YY_M1T");
    String PIS_MM_M1T     = request.getParameter("PIS_MM_M1T");

        String PIS_YY_Y3  = request.getParameter("PIS_YY_Y3");
        String PIS_MM_Y3  = request.getParameter("PIS_MM_Y3");
        String PIS_YY_Y0  = request.getParameter("PIS_YY_Y0");
        String PIS_MM_Y0  = request.getParameter("PIS_MM_Y0");
        String PIS_YY_Y1  = request.getParameter("PIS_YY_Y1");
        String PIS_MM_Y1  = request.getParameter("PIS_MM_Y1");

    if (HEAD_TAG.equals("3")) {
         PIS_YY_Y0  = PIS_YY_Y3;
         PIS_MM_Y0  = PIS_MM_Y3;
         PIS_YY_Y1  = PIS_YY_Y3;
         PIS_MM_Y1  = PIS_MM_Y3;
    } else if (HEAD_TAG.equals("0")) {
         PIS_YY_Y1  = "";
         PIS_MM_Y1  = "";
	} else {
         PIS_YY_Y0  = "";
         PIS_MM_Y0  = "";
	} 
 
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String Query = XmlSqlUtils.getSQL("tax", "TAXA110_SHR");
    StringBuffer sql_head_tag = new StringBuffer();

    //param binding 하기
      Object[] bind = null;
      bind = new Object[] {
             PIS_YY_A0,  PIS_MM_A0,
             PIS_YY_A1F, PIS_MM_A1F,
             PIS_YY_A1T, PIS_MM_A1T,
             PIS_YY_M0,  PIS_MM_M0,
             PIS_YY_M1F, PIS_MM_M1F,
             PIS_YY_M1T, PIS_MM_M1T,
             PIS_YY_Y0,  PIS_MM_Y0,
             PIS_YY_Y1,  PIS_MM_Y1,
             PIS_YY_Y1,  PIS_MM_Y1
    };


    if(!HEAD_TAG.equals("3")) {
        sql_head_tag.append("AND D.HEAD_TAG   = '" + HEAD_TAG + "'");
    } 

    //DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다
    Object[] sqlParam = new Object[] {
            sql_head_tag.toString(),
            sql_head_tag.toString()
    };
    
    //[1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("ENO_CNT");
    hnwExtQuery.AddField("BENO_CNT");
    hnwExtQuery.AddField("GENO_CNT");
    hnwExtQuery.AddField("SALT_AMT");
    hnwExtQuery.AddField("SALB_AMT");
    hnwExtQuery.AddField("SALG_AMT");
    hnwExtQuery.AddField("CUR_DATE");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("ENO_CNT"));
            hnwExtQuery.AddData(vo.getString("BENO_CNT"));
            hnwExtQuery.AddData(vo.getString("GENO_CNT"));
            hnwExtQuery.AddData(vo.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo.getString("SALB_AMT"));
            hnwExtQuery.AddData(vo.getString("SALG_AMT"));
            hnwExtQuery.AddData(vo.getString("CUR_DATE"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
