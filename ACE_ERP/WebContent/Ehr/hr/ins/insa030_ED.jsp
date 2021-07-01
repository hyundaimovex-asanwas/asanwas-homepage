<!--
***********************************************************************
* @source      : insa030_ED.jsp
* @description : ���ο��� ���κ� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/07      ���м�        �����ۼ�.        
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
    String eno_no = request.getParameter("eno_no");
    String str_yy = request.getParameter("str_yy");
    String end_yy = request.getParameter("end_yy");

    StringBuffer sb  = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("ins", "INSA030_SHR02");
    
    /** ��ȸ ���ǿ� ���� ó�� **/
    if (!str_yy.equals("") && !end_yy.equals("")) {
        sb.append("AND     PIS_YY >= '"+str_yy+"' \n");
        sb.append("                     AND     PIS_YY <= '"+end_yy+"'");
    } else if (!str_yy.equals("") && end_yy.equals("")) {
        sb.append("AND     PIS_YY >= '"+str_yy+"'");
    } else if (str_yy.equals("") && !end_yy.equals("")) {
        sb.append("AND     PIS_YY <= '"+end_yy+"'");
    }
    
    if( ! end_yy.equals("") ){ 
        sb2.append("WHERE   ENO_NO = '"+eno_no+"'");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        sb.toString(),
        sb2.toString()
    };
    
    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {};
		
    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("ǥ�غ�������");
    hnwExtQuery.AddField("���κδ��");
    hnwExtQuery.AddField("ȸ��δ��");
    hnwExtQuery.AddField("�հ�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int cnt = 0;
    int monCnt = 0;
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size()-1; i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            if ( end_yy.equals(vo.getString("PIS_YY")) ) {
                cnt = cnt + 1;
            }
            
            if(vo.getString("PIS_MM").equals("�Ұ�")){
           		for(int j=monCnt; j<12; j++){
           			hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
             
                    hnwExtQuery.SendData(response); 
           		}

            }else{
            	monCnt = monCnt + 1;
            }
            
            hnwExtQuery.AddData(vo.getString("PIS_MM"));
            hnwExtQuery.AddData(vo.getString("NPN_GRD"));
            hnwExtQuery.AddData(vo.getString("STDB_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("COM_AMT"));
            hnwExtQuery.AddData(vo.getString("NPN_SUM"));
  
            hnwExtQuery.SendData(response);
            //System.out.println("-->"+vo.getString("PIS_YY")+",    "+vo.getString("PIS_MM"));
        }
        for ( int i=0; i<12-cnt; i++ )        //���������� ����ó��(�Ѱ谡 ������������ ���;���)
        {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
  
            hnwExtQuery.SendData(response); 
        }

        DynamicValueObject vo = (DynamicValueObject)voList.get(voList.size()-1);   //�Ѱ�

        hnwExtQuery.AddData(vo.getString("PIS_MM"));
        hnwExtQuery.AddData(vo.getString("NPN_GRD"));
        hnwExtQuery.AddData(vo.getString("STDB_AMT"));
        hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
        hnwExtQuery.AddData(vo.getString("COM_AMT"));
        hnwExtQuery.AddData(vo.getString("NPN_SUM"));

        hnwExtQuery.SendData(response);    
    }

%>