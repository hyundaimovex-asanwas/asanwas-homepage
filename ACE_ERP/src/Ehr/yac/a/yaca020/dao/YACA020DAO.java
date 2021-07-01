package Ehr.yac.a.yaca020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class YACA020DAO extends AbstractDAO {

	/**
	 * YACA020DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * JSP를 위해 생성자 추가
     * Transaction 은 처리하지않음
     * @param p_conn
     * @throws CException
     */
    public YACA020DAO(String p_conn) throws CException {
        super(p_conn);
    }

    /**
     * 연말정산내역 을 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA020_SHR(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }

    /**
     * 개인정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_01(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_01");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }

    /**
     * 개인정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_14(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR2_14");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }    
    
    /**
     * 개인정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_142(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR2_142");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }       
    
    /**
     * 개인정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_15(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR2_15");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };
 
        this.selectProcessFirstRow(Query, bind, prop);

    }       
    
    /**
     * 출력정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_PRT_14(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR2_PRT_14");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO")),
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        prop.add("HOL_YN", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CLS_TAG", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);        
        
        this.selectProcessFirstRow(Query, bind, prop);

    }    

    /**
     * 출력정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_PRT_142(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR2_PRT_142");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO")),
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        prop.add("HOL_YN", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CLS_TAG", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);        
        
        this.selectProcessFirstRow(Query, bind, prop);

    }        
    
    /**
     * 출력정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_PRT_15(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR2_PRT_15");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO")),
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        prop.add("HOL_YN",  ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("CLS_TAG", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);    
        prop.add("LUN_CHK", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("INS_TAG", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);   
        
        this.selectProcessFirstRow(Query, bind, prop);

    }        
    
    /**
     * 출력 부양가족정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR3_PRT_14(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR3_PRT_14");

        //param binding 하기
        Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }        
    
    /**
     * 출력 부양가족정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR3_PRT_142(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR3_PRT_142");

        //param binding 하기
        Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }       
    
    /**
     * 출력 부양가족정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR3_PRT_15(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR3_PRT_15");

        //param binding 하기
        Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }       
    
    /**
     *  2,3 페이지 정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR4_PRT_14(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR4_PRT_14");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO")),
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }      
    
    /**
     *  2,3 페이지 정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR4_PRT_142(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR4_PRT_142");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO")),
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }      
    
    /**
     *  2,3 페이지 정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR4_PRT_15(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR4_PRT_15");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO")),
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }      
    
    /**
     *  7 페이지 연금정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR5_PRT_14(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR5_PRT_14");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }      
    
    /**
     *  7 페이지 연금정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR5_PRT_142(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR5_PRT_142");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }        
    
    /**
     *  7 페이지 연금정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR5_PRT_15(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR5_PRT_15");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))                
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }        
    
    /**
     * 2013년도 연말정산내역 을 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA020_SHR_13(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_13");
        
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());
    	
        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))        		
                ,JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    
    /**
     * 2014년도 연말정산내역 을 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA020_SHR_14(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_14");
        
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());
    	
        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))        		
                ,JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }    
    
    /**
     * 2014년도 연말정산내역 을 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA020_SHR_142(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_142");
        
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());
    	
        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))        		
                ,JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    
    /**
     * 2015년도 연말정산내역 을 가져온다.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA020_SHR_15(CBox p_box) throws CException {
    	
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_15");
        
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());
    	
        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))        		
                ,JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    
    
    
    /**
     * 전년도 부양가족정보 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_OLD(CBox p_box) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_OLD");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };

        this.selectProcessFirstRow(Query, bind, prop);

    }
    
    
    /**
     * 수정한 개인연금 내역을 DB에 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA020_UPT(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_UPT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("SOU_CNT")
                ,vo.get("DFM_CNT")
                ,vo.get("TRB_CNT")
                ,vo.get("GOL_CNT70")
                ,vo.get("GOL_CNT70")
                ,vo.get("WCT_CNT")
                ,vo.get("RCH_CNT")
                ,vo.get("CHI_CNT")

                //,vo.get("NPEN_AMT") //조회용
                //,vo.get("EPEN_AMT") //조회용
                //,vo.get("HINU_AMT") //조회용
                //,vo.get("HINS_AMT") //조회용
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")

                ,vo.get("MHEA_AMT")
                ,vo.get("OHEA_AMT")
                ,vo.get("MHEA_AMT")
                ,vo.get("OHEA_AMT")
                ,vo.get("LF2_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("LEN_AMT2")
                ,vo.get("LEN_AMT3")
                ,vo.get("LEN_AMT4")
                ,vo.get("LEN_AMT5")
                ,vo.get("GRA_AMT")
                ,vo.get("EDU_AMT1")
                ,vo.get("EDU_AMT2")
                ,vo.get("EDU_AMT3")
                ,vo.get("EDU_AMT4")
                ,vo.get("EDU_AMT5")
                ,vo.get("EDU_TAG1")
                ,vo.get("EDU_TAG2")
                ,vo.get("EDU_TAG3")
                ,vo.get("EDU_TAG4")
                ,vo.get("EDU_TAG5")
                ,vo.get("HED_AMT")
                ,vo.get("LHO_AMT")
                ,vo.get("LHP_AMT")
                ,vo.get("LHQ_AMT")
                ,vo.get("LHR_AMT")
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH2_AMT04")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")                
                ,vo.get("LC3_AMT")
                ,vo.get("GOV_AMT")
                ,vo.get("LC1_AMT")
                ,vo.get("LC2_AMT")
                ,vo.get("WED_CNT")
                ,vo.get("LC3_NTS")
                ,vo.get("GOV_NTS")
                ,vo.get("LC1_NTS")
                ,vo.get("LC2_NTS")
                ,vo.get("MOV_CNT")
                ,vo.get("FUN_CNT")
                ,vo.get("LF1_AMT")
                ,vo.get("ANN_AMT")
                ,vo.get("VEN2_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")

                ,vo.get("LST_AMT")
                //TMP1_AMT 존재하지않는필드
                ,vo.get("GOV_DED")
                //PAYO_SUM = PAYO_AMTS+PAYO_AMTB
                //LSQ_AMT

                ,vo.get("CASH_AMT")
                ,vo.get("GIRO_AMT")
                ,vo.get("STOCK_AMT3")
                ,vo.get("HOL_YN")
                ,SES_ENO_NO
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }

    
    /**
     * 수정한 개인연금 내역을 DB에 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA020_UPT_13(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_UPT_13");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("SOU_CNT")
                ,vo.get("DFM_CNT")
                ,vo.get("TRB_CNT")
                ,vo.get("GOL_CNT70")
                ,vo.get("GOL_CNT70")
                ,vo.get("WCT_CNT")
                ,vo.get("RCH_CNT")
                ,vo.get("CHI_CNT")


                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")

                ,vo.get("MHEA_AMT")
                ,vo.get("OHEA_AMT")
                ,vo.get("MHEA_AMT")
                ,vo.get("OHEA_AMT")
                
                ,vo.get("LF2_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("LEN_AMT2")
                ,vo.get("LEN_AMT3")
                ,vo.get("LEN_AMT4")
                ,vo.get("LEN_AMT5")
                ,vo.get("GRA_AMT")
                
                ,vo.get("EDU_AMT1")
                ,vo.get("EDU_AMT2")
                ,vo.get("EDU_AMT3")
                ,vo.get("EDU_AMT4")
                ,vo.get("EDU_AMT5")
                ,vo.get("EDU_TAG1")
                ,vo.get("EDU_TAG2")
                ,vo.get("EDU_TAG3")
                ,vo.get("EDU_TAG4")
                ,vo.get("EDU_TAG5")
                ,vo.get("HED_AMT")
                
                ,vo.get("LHO_AMT")
                ,vo.get("LHP_AMT")
                ,vo.get("LHQ_AMT")
                ,vo.get("LHR_AMT")
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH2_AMT04")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")       
                

                ,vo.get("GOV_AMT")
                ,vo.get("LC1_AMT")
                ,vo.get("LC2_AMT")
                ,vo.get("LC3_AMT")                

                ,vo.get("GOV_NTS")
                ,vo.get("LC1_NTS")
                ,vo.get("LC2_NTS")
                ,vo.get("LC3_NTS")
                
                ,vo.get("FUN_CNT")
                ,vo.get("LF1_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("HOL_YN")
                ,SES_ENO_NO
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    
    
    /**
     * 종전 근무지 내역 가져오기
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet YACA020_SHR_PLA(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_SHR_PLA");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("HIR_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);


        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }

    /**
     * 종전 근무지 내역 모두 삭제
     * @param p_box
     * @throws CException
     */
    public void YACA020_DEL_PLA(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_DEL_PLA");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        this.deleteProcess(Query, bind);
    }

    /**
     * 종전 근무지 내역 등록
     * @param p_box
     * @throws CException
     */
    public void YACA020_INS_PLA(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA020_INS_PLA");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("SEQ_NO")
                ,vo.get("JAO_NO")
                ,vo.get("JAS_NM")
                ,vo.get("HIR_YMD").replaceAll("-", "")
                ,vo.get("RET_YMD").replaceAll("-", "")
                ,vo.get("JAA_AMT")
                ,vo.get("JAC_AMT")
                ,vo.get("JAG_AMT")
                ,vo.get("JAI_AMT")
                ,vo.get("JAQ_AMT")
                ,vo.get("JAR_AMT")
                ,vo.get("JAH_AMT")
                ,vo.get("JAP_AMT")
                ,vo.get("JAL_AMT")
                ,vo.get("JAN_AMT")
                ,Double.toString(Double.parseDouble(vo.get("JAA_AMT")) + Double.parseDouble(vo.get("JAC_AMT")) + Double.parseDouble(vo.get("JAI_AMT")))
                ,SES_ENO_NO
                ,SES_ENO_NO
        };

        this.insertProcess(Query, bind);
    }

	/**
	 * 주소 수정
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void YACA020_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("ZIP_NO").replaceAll("-", ""),// 등본상거주지 우편번호
				vo.get("ADDRESS"),                   // 등본상 거주지주소1
				vo.get("ADR_CT"),                    // 등본상거주지 주소2
				p_box.get("SESSION_ENONO"),          // 수정자
				p_box.get("SESSION_GUBUN"),          // 회계단위
				vo.get("ENO_NO")                     // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}


	public void YACA020_UPT_CLS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_CLS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {

				p_box.get("CLS_TAG"),          	//TAG
				p_box.get("ENO_NO"),          	//TAG
                p_box.get("PIS_YY")				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	public void YACA020_UPT_CLS_14(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_CLS_14");
		
		System.out.println("YACA020_UPT_CLS_14 \n" + sql.toString());	
		
		System.out.println("p_box" + p_box);			
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {

				p_box.get("CLS_TAG"),          	//TAG
				p_box.get("ENO_NO"),          	//TAG
                p_box.get("PIS_YY")				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}	
	
	
	public void YACA020_UPT_CLS_142(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_CLS_142");
		
		//System.out.println("YACA020_UPT_CLS_14 \n" + sql.toString());	
		
		//System.out.println("p_box" + p_box);			
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {

				p_box.get("CLS_TAG"),          	//TAG
				p_box.get("ENO_NO"),          	//TAG
                p_box.get("PIS_YY")				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}		
	
	
	
	
	public void YACA020_UPT_CLS_15(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_CLS_15");
		
		//System.out.println("YACA020_UPT_CLS_14 \n" + sql.toString());	
		
		//System.out.println("p_box" + p_box);			
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {

				p_box.get("CLS_TAG"),          	//TAG
				p_box.get("ENO_NO"),          	//TAG
                p_box.get("PIS_YY")				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}		
	
	public void YACA020_UPT_END(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_END");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				p_box.get("SUBMIT_TAG"),          		//TAG	
				p_box.get("SESSION_ENONO"),          	// 수정자				
				p_box.get("ENO_NO"),          				//ENO_NO
                p_box.get("PIS_YY")		
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	
	public void YACA020_UPT_END_14(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_END_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				p_box.get("SUBMIT_TAG"),          		//TAG	
				p_box.get("vusrid"),          				// 수정자				
				p_box.get("ENO_NO"),          				//ENO_NO
                p_box.get("PIS_YY")		
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	
	public void YACA020_UPT_END_142(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_END_142");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				p_box.get("SUBMIT_TAG"),          		//TAG	
				p_box.get("vusrid"),          				// 수정자				
				p_box.get("ENO_NO"),          				//ENO_NO
                p_box.get("PIS_YY")		
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}	
	
	public void YACA020_UPT_END_15(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA020_UPT_END_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				p_box.get("SUBMIT_TAG"),          		//TAG	
				p_box.get("vusrid"),          				// 수정자				
				p_box.get("ENO_NO"),          				//ENO_NO
                p_box.get("PIS_YY")		
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}	
	
}
