package Ehr.yac.a.yaca021.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA021DAO extends AbstractDAO {
    private GauceDataSet ds;

	/**
	 * INSB021DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA021DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 부양가족 내역을 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }

    
    /**
     * 2013년도 부양가족 내역을 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_13(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_13");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * 2014년도 부양가족 내역을 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("ENO_NO")        		
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 2014년도 부양가족 내역을 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("ENO_NO")        		
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }     
    
    /**
     * 2015년도 부양가족 내역을 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("ENO_NO")        		
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        
        System.out.println("YACA021_SHR_15::"+Query);

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }     
    
    
    /**
     * 부양가족 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }

    /**
     * 부양가족 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * 부양가족 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 부양가족 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_INFO_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_INFO_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    
    
    /**
     * 개인간 주택임차차입금 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * 개인간 주택임차차입금 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * 개인간 주택임차차입금 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 개인간 주택임차차입금 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_PER_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_PER_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);   
		prop.add("AMOUNT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);     
		prop.add("INT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    		
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * 월세계약 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    /**
     * 월세계약 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    /**
     * 월세계약 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }      
    
    /**
     * 월세계약 상세 내역 가져오기
     * @param p_box
     * @throws CException
     */
    public void YACA021_SHR_RENT_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_RENT_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 9, ColumnProp.CONSTRAINT_TB_NORMAL);    
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }      
    
    /**
     * 부양가족 내역을 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("RCH_MAN")							//6세이하
                ,vo.get("CHI_MAN")							//다자녀추가공제
                ,vo.get("INP_MAN")  							//출산입양공제
                ,vo.get("ONE_PARENT")  					//한부모공제                
                
                ,vo.get("LIN_AMT_NTS")					//보험료
                ,vo.get("LIH_AMT_NTS")					//장애인전용보험료
                ,vo.get("MED_AMT_NTS")					//의료비   
                ,vo.get("LEN_AMT_NTS")					//시력보정의료비
                ,vo.get("EDU_AMT_NTS")					//교육비 
                ,vo.get("HED_AMT_NTS")					//장애인특수교육비
                ,vo.get("CARD_AMT_NTS")				//신용카드  
                ,vo.get("DIR_CARD_AMT_NTS")			//직불체크카드사용액
                ,vo.get("CASH_AMT_NTS")				//현금영수증  
                ,vo.get("MARKET_AMT_NTS")             //전통시장
                ,vo.get("PUBLIC_AMT_NTS")				//대중교통이용
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//주택자금_대출기관
                ,vo.get("LH2_AMT04")					//장기주택차입이자액(10~15년)
                ,vo.get("LH2_AMT")						//장기주택차입이자액(15년이상)
                ,vo.get("LH4_AMT")						//장기주택차입이자액(30년이상)
                ,vo.get("LH5_AMT")						//개인간 주택임차원리금상환액
                ,vo.get("LH6_AMT")						//월세액
                ,vo.get("LH7_AMT")						//2012년 이후 고정금리/비거치
                ,vo.get("LH8_AMT")                		//2012년 이후 기타대출
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT04_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")                

                ,SES_ENO_NO
                ,SES_ENO_NO
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }
    
    
    
    
    
    /**
     * 부양가족 내역을 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS_14");

        //System.out.println("p_box1   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());        
        //String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  						//한부모공제                
                
                ,vo.get("LIN_AMT_NTS")					//보험료
                ,vo.get("LIH_AMT_NTS")					//장애인전용보험료
                ,vo.get("MED_AMT_NTS")					//의료비   
                ,vo.get("LEN_AMT_NTS")					//시력보정의료비
                ,vo.get("EDU_AMT_NTS")					//교육비 
                ,vo.get("HED_AMT_NTS")					//장애인특수교육비
                ,vo.get("CARD_AMT_NTS")					//신용카드  
                ,vo.get("DIR_CARD_AMT_NTS")			//직불체크카드사용액
                ,vo.get("CASH_AMT_NTS")					//현금영수증  
                ,vo.get("MARKET_AMT_NTS")             //전통시장
                ,vo.get("PUBLIC_AMT_NTS")				//대중교통이용
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//            

                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//주택자금_대출기관
                ,vo.get("LH2_AMT")						//개인간 주택임차원리금상환액
                ,vo.get("LH3_AMT")						//장기주택차입이자액(10~15년)
                ,vo.get("LH4_AMT")						//장기주택차입이자액(15~29년)
                ,vo.get("LH5_AMT")						//장기주택차입이자액(30년이상)
                ,vo.get("LH6_AMT")						//월세액
                ,vo.get("LH7_AMT")						//2012년 이후 고정금리/비거치
                ,vo.get("LH8_AMT")                		//2012년 이후 기타대출
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")                

                ,vo.get("SAJU_AMT_NTS")
                ,vo.get("SAJU_AMT")                  
                
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")                

        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }

    /**
     * 부양가족 내역을 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS_142");

        //System.out.println("p_box1   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());        
        //String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  						//한부모공제                
                
                ,vo.get("LIN_AMT_NTS")					//보험료
                ,vo.get("LIH_AMT_NTS")					//장애인전용보험료
                ,vo.get("MED_AMT_NTS")					//의료비   
                ,vo.get("LEN_AMT_NTS")					//시력보정의료비
                ,vo.get("EDU_AMT_NTS")					//교육비 
                ,vo.get("HED_AMT_NTS")					//장애인특수교육비
                ,vo.get("CARD_AMT_NTS")					//신용카드  
                ,vo.get("DIR_CARD_AMT_NTS")			//직불체크카드사용액
                ,vo.get("CASH_AMT_NTS")					//현금영수증  
                ,vo.get("MARKET_AMT_NTS")             //전통시장
                ,vo.get("PUBLIC_AMT_NTS")				//대중교통이용
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//            

                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//주택자금_대출기관
                ,vo.get("LH2_AMT")						//개인간 주택임차원리금상환액
                ,vo.get("LH3_AMT")						//장기주택차입이자액(10~15년)
                ,vo.get("LH4_AMT")						//장기주택차입이자액(15~29년)
                ,vo.get("LH5_AMT")						//장기주택차입이자액(30년이상)
                ,vo.get("LH6_AMT")						//월세액
                ,vo.get("LH7_AMT")						//2012년 이후 고정금리/비거치
                ,vo.get("LH8_AMT")                		//2012년 이후 기타대출
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")                

                ,vo.get("SAJU_AMT_NTS")
                ,vo.get("SAJU_AMT")                  
                
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")                

        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }
    
    
    /**
     * 부양가족 내역을 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_INS_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_INS_15");

        //System.out.println("p_box1   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());        
        //String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("REL_CD")
                ,vo.get("NAM_KOR")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  					//한부모공제              
                ,vo.get("INP_MAN")  					//             
                ,vo.get("RCH_MAN")  					//             
                
                ,vo.get("LIN_AMT_NTS")					//보험료
                ,vo.get("LIH_AMT_NTS")					//장애인전용보험료
                ,vo.get("MED_AMT_NTS")					//의료비   
                ,vo.get("LEN_AMT_NTS")					//시력보정의료비
                ,vo.get("EDU_AMT_NTS")					//교육비 
                ,vo.get("HED_AMT_NTS")					//장애인특수교육비
                ,vo.get("CARD_AMT_NTS")					//신용카드  
                ,vo.get("DIR_CARD_AMT_NTS")			    //직불체크카드사용액
                ,vo.get("CASH_AMT_NTS")					//현금영수증  
                ,vo.get("MARKET_AMT_NTS")               //전통시장
                ,vo.get("PUBLIC_AMT_NTS")				//대중교통이용
                
                ,vo.get("CARD_2013_AMT")				//본인 2013년도 신용카드등 사용액
                ,vo.get("CARD_2014_AMT")				//본인 2014년도 신용카드등 사용액  
                ,vo.get("CARD_2013_OVER")             	//본인 2013년도 추가공제율 사용분
                ,vo.get("CARD_2014_OVER")				//본인 2014년도 추가공제율 사용분  
                ,vo.get("CARD_2015_AMT")                //본인 2015년도 신용카드등 사용액
                ,vo.get("CARD_2015_FH_OVER")            //본인 2015년도 상반기 추가공제율 사용분  
                ,vo.get("CARD_2015_SH_OVER")            //본인 2015년도 하반기 추가공제율 사용분 

                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")
                
                ,vo.get("LH1_AMT")    					//주택자금_대출기관
                ,vo.get("LH2_AMT")						//개인간 주택임차원리금상환액
                ,vo.get("LH3_AMT")						//장기주택차입이자액(10~15년)
                ,vo.get("LH4_AMT")						//장기주택차입이자액(15~29년)
                ,vo.get("LH5_AMT")						//장기주택차입이자액(30년이상)
                ,vo.get("LH6_AMT")						//월세액
                ,vo.get("LH7_AMT")						//2012년 이후 고정금리/비거치
                ,vo.get("LH8_AMT")                		//2012년 이후 기타대출
                ,vo.get("LH9_AMT")                		//2015년 15년이상 고정 그리고 비거치
                ,vo.get("LH10_AMT")                		//2015년 15년이상 고정 또는 비거치
                ,vo.get("LH11_AMT")                		//2015년 15년이상 일반대출
                ,vo.get("LH12_AMT")                		//2015년 10~14년 고정 또는 비거치
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")  
                ,vo.get("LH9_AMT_NTS")  
                ,vo.get("LH10_AMT_NTS")  
                ,vo.get("LH11_AMT_NTS")  
                ,vo.get("LH12_AMT_NTS")  

                ,vo.get("SAJU_AMT_NTS")
                ,vo.get("SAJU_AMT")                  
                
                ,p_box.get("vusrid")
                ,p_box.get("vusrid")                

        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }
    
    
    /**
     * 부양가족 내역을 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")

                ,vo.get("ONE_PARENT")  	                         
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT04")
                ,vo.get("LH2_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")              
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT04_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")            
                
                ,vo.get("HOL_YN")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }

    
    /**
     * 부양가족 내역을 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_14(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_14");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  	                         
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//  
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH3_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")              
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")            
                
                ,vo.get("SAJU_AMT_NTS")                
                ,vo.get("SAJU_AMT")
                
                ,vo.get("HOL_YN")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * 부양가족 내역을 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_142(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_142");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.get("BAS_MAN")
                ,vo.get("GOL_70")
                ,vo.get("TRB_MAN")
                ,vo.get("INV_MAN")                
                ,vo.get("WCT_MAN")
                ,vo.get("ONE_MAN")  	                         
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//  
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH3_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")              
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")            
                
                ,vo.get("SAJU_AMT_NTS")                
                ,vo.get("SAJU_AMT")
                
                ,vo.get("HOL_YN")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
       
    /**
     * 부양가족 내역을 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_15(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_15");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.get("BAS_MAN")  //기본공제
                ,vo.get("GOL_70")   //경로우대공제
                ,vo.get("TRB_MAN")  //장애인공제
                ,vo.get("INV_MAN")  //장애여부              
                ,vo.get("WCT_MAN")  //부녀자공제
                ,vo.get("ONE_MAN")  //한부모공제
                ,vo.get("INP_MAN")  //출산입양 추가
                ,vo.get("RCH_MAN")  //6세이하 추가
                
                ,vo.get("LIN_AMT_NTS")
                ,vo.get("LIH_AMT_NTS")
                ,vo.get("MED_AMT_NTS")
                ,vo.get("LEN_AMT_NTS")
                ,vo.get("EDU_AMT_NTS")
                ,vo.get("HED_AMT_NTS")
                
                ,vo.get("CARD_AMT_NTS")
                ,vo.get("DIR_CARD_AMT_NTS")
                ,vo.get("CASH_AMT_NTS")
                ,vo.get("MARKET_AMT_NTS")                
                ,vo.get("PUBLIC_AMT_NTS")
                
                ,vo.get("LIN_AMT")
                ,vo.get("LIH_AMT")
                ,vo.get("MED_AMT")
                ,vo.get("LEN_AMT")
                ,vo.get("EDU_TAG")
                ,vo.get("EDU_AMT")
                ,vo.get("HED_AMT")
                
                ,vo.get("CARD_AMT")
                ,vo.get("DIR_CARD_AMT")
                ,vo.get("CASH_AMT")
                ,vo.get("MARKET_AMT")                
                ,vo.get("PUBLIC_AMT")      
                
                ,vo.get("CARD_2013_AMT")				//
                ,vo.get("CARD_2014_AMT")				//  
                ,vo.get("CARD_2013_OVER")             	//
                ,vo.get("CARD_2014_OVER")				//  
                ,vo.get("CARD_2015_AMT")				//  
                ,vo.get("CARD_2015_FH_OVER")    		//  
                ,vo.get("CARD_2015_SH_OVER")			//  
                
                ,vo.get("LH1_AMT")
                ,vo.get("LH2_AMT")
                ,vo.get("LH3_AMT")
                ,vo.get("LH4_AMT")
                ,vo.get("LH5_AMT")
                ,vo.get("LH6_AMT")
                ,vo.get("LH7_AMT")
                ,vo.get("LH8_AMT")      
                ,vo.get("LH9_AMT")     
                ,vo.get("LH10_AMT")     
                ,vo.get("LH11_AMT")     
                ,vo.get("LH12_AMT")     
                
                ,vo.get("LH1_AMT_NTS")
                ,vo.get("LH2_AMT_NTS")
                ,vo.get("LH3_AMT_NTS")
                ,vo.get("LH4_AMT_NTS")
                ,vo.get("LH5_AMT_NTS")
                ,vo.get("LH6_AMT_NTS")
                ,vo.get("LH7_AMT_NTS")
                ,vo.get("LH8_AMT_NTS")
                ,vo.get("LH9_AMT_NTS")
                ,vo.get("LH10_AMT_NTS")
                ,vo.get("LH11_AMT_NTS")
                ,vo.get("LH12_AMT_NTS")
                
                ,vo.get("SAJU_AMT_NTS")                
                ,vo.get("SAJU_AMT")
                
                ,vo.get("HOL_YN")
                ,vo.get("INS_TAG")
                ,p_box.get("vusrid")              
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("CET_NO").replaceAll("-", "")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    
    /**
     * 부양가족 내역 삭제
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.deleteProcess(Query, bind);
    }

    
    /**
     * 부양가족 내역 삭제
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL_14(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.deleteProcess(Query, bind);
    }    
    
    /**
     * 부양가족 내역 삭제
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL_142(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.deleteProcess(Query, bind);
    }       
    
    /**
     * 부양가족 내역 삭제
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_DEL_15(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_DEL_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 vo.get("PIS_YY")
                ,vo.get("ENO_NO")
                ,vo.get("CET_NO").replaceAll("-", "")
        };

        //값 보내고 DataSet 가져오기
        this.deleteProcess(Query, bind);
    }       
    
    
    /**
     * 월세액 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")             
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }
    

    /**
     * 월세액 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT_14");
        
        
		//System.out.print("p_boxYACA021_SAV_RENT_14================= "+p_box);
		//System.out.print("vo================= "+vo);		
		
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.getString("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.getString("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")             
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * 월세액 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT_142");
        
        
		//System.out.print("p_boxYACA021_SAV_RENT_14================= "+p_box);
		//System.out.print("vo================= "+vo);		
		
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.getString("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.getString("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")             
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * 월세액 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_RENT_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_RENT_15");
        
        
		System.out.print("p_boxYACA021_SAV_RENT_15================= "+p_box);
		System.out.print("vo================= "+vo);		
		
        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.getString("HOST_NM")
                ,vo.get("CET_NO").replaceAll("-", "")
                ,vo.getString("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD").replaceAll("-", "")
                ,vo.get("DUE_YMD").replaceAll("-", "")   
                ,vo.get("HOUSE_TYPE")
                ,vo.get("HOUSE_AREA")
                ,p_box.get("vusrid") 
                ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * 월세액 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.getString("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")     
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * 월세액 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT_14");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.get("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")     
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * 월세액 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT_142");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.get("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")     
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }      
    
    /**
     * 월세액 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_RENT_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_RENT_15");

        //param binding 하기
        Object[] bind = new Object[] {
        		
                 vo.get("HOST_NM")
                ,vo.get("CET_NO")
                ,vo.get("ADDRESS")
                ,vo.get("AMOUNT")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")
                ,vo.get("HOUSE_TYPE")
                ,vo.get("HOUSE_AREA")
                ,p_box.get("vusrid")                 
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
    
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }      
    
    
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }      
    
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2_14");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }      
        
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2_142");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }  
    
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM2_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM2_15");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }  
    
    /**
     * 개인간 주택임차차입금 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")         
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }

    
    /**
     * 개인간 주택임차차입금 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER_14");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")         
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }

    /**
     * 개인간 주택임차차입금 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER_142");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")         
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    /**
     * 개인간 주택임차차입금 항목 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_SAV_PER_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SAV_PER_15");

        //param binding 하기
        Object[] bind = new Object[] {
                p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
               ,vo.get("HOST_NM")
               ,vo.get("CET_NO").replaceAll("-", "")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD").replaceAll("-", "")
               ,vo.get("DUE_YMD").replaceAll("-", "")  
               ,vo.get("HOUSE_TYPE")
               ,vo.get("HOUSE_AREA")
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")                    
               ,p_box.get("vusrid") 
               ,p_box.get("vusrid") 
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    
    
    
    /**
     * 개인간 주택임차차입금 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD")     
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }    
    
    
    /**
     * 개인간 주택임차차입금 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER_14");

        //param binding 하기
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD")     
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }        
    
    /**
     * 개인간 주택임차차입금 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER_142");

        //param binding 하기
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD")     
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * 개인간 주택임차차입금 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_PER_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PER_15");

        //param binding 하기
        Object[] bind = new Object[] {
                vo.get("HOST_NM")
               ,vo.get("CET_NO")
               ,vo.get("ADDRESS")
               ,vo.get("AMOUNT")
               ,vo.get("CON_YMD")
               ,vo.get("DUE_YMD") 
               ,vo.get("HOUSE_TYPE")
               ,vo.get("HOUSE_AREA")
               ,vo.get("HOST_NM2")
               ,vo.get("CET_NO2").replaceAll("-", "")
               ,vo.get("AMOUNT2")
               ,vo.get("INT_AMT")
               ,vo.get("INT_PER")               
               ,vo.get("CON2_YMD").replaceAll("-", "")
               ,vo.get("DUE2_YMD").replaceAll("-", "")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }       
    
    
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }      
    
    
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM_14(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM_14");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }      
        
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM_142(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM_142");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }  
    
    
    /**
     * T_AC_FAMILY 항목 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void YACA021_UPT_FAM_15(CBox p_box, GauceValueObject vo) throws CException {

        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_FAM_15");

        //param binding 하기
        Object[] bind = new Object[] {
               vo.get("AMOUNT2")
               ,p_box.get("vusrid")                 
               ,p_box.get("PIS_YY")
               ,p_box.get("ENO_NO")
        };

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }  
    
    /**
     * 가족 사항 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }
    
    /**
     * 가족 사항 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }
    
    /**
     * 가족 사항 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }    
    
    /**
     * 가족 사항 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_CNT_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_CNT_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }    
    
    

    /**
     * 가족 사항 전체 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }

    /**
     * 가족 사항 전체 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }    
    
    /**
     * 가족 사항 전체 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }      
    
    
    /**
     * 가족 사항 전체 조회
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceValueObject YACA021_SHR_ALL_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_SHR_ALL_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //값 보내고 DataSet 가져오기
        return this.selectProcessGvo(Query, bind);
    }      
    
    
    /**
     * 부양가족 내역중 변경 된 사항을 정산 테이블에 수정한다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_ACC(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("LF2_AMT")
                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("LC1_AMT")   //기부금
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                ,p_box.get("LC4_AMT")
                
                ,p_box.get("LH1_AMT")   //주택자금
                ,p_box.get("LH2_AMT04")
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")            
                
                ,p_box.get("HOL_YN")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //수정하기
        this.updateProcess(Query, bind);
    }

    
    /**
     * 부양가족 내역중 변경 된 사항을 정산 테이블에 수정한다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_ACC_14(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC_14");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")

                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("CARD_2013_AMT")
                ,p_box.get("CARD_2014_AMT")
                ,p_box.get("CARD_2013_OVER")
                ,p_box.get("CARD_2014_OVER")    

                ,p_box.get("LC1_AMT")   //기부금
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                
                ,p_box.get("LH1_AMT")   //주택자금
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH3_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")            
                
                ,p_box.get("SAJU_AMT")     
                
                ,p_box.get("HOL_YN")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //수정하기
        this.updateProcess(Query, bind);
    }    
    
    /**
     * 부양가족 내역중 변경 된 사항을 정산 테이블에 수정한다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_ACC_142(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC_142");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")

                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("CARD_2013_AMT")
                ,p_box.get("CARD_2014_AMT")
                ,p_box.get("CARD_2013_OVER")
                ,p_box.get("CARD_2014_OVER")    

                ,p_box.get("LC1_AMT")   //기부금
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                
                ,p_box.get("LH1_AMT")   //주택자금
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH3_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")            
                
                ,p_box.get("SAJU_AMT")     
                
                ,p_box.get("HOL_YN")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //수정하기
        this.updateProcess(Query, bind);
    }    
    
    
    public void YACA021_UPT_ACC_15(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_ACC_15");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                ,p_box.get("INP_CNT")
                ,p_box.get("RCH_CNT")
                
                ,p_box.get("LIN_AMT")
                ,p_box.get("LIH_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")
                ,p_box.get("MHEA_AMT")
                ,p_box.get("OHEA_AMT")

                
                ,p_box.get("LEN_AMT")
                ,p_box.get("LEN_AMT2")
                ,p_box.get("LEN_AMT3")
                ,p_box.get("LEN_AMT4")
                ,p_box.get("LEN_AMT5")
                ,p_box.get("EDU_TAG1")
                ,p_box.get("EDU_AMT1")
                ,p_box.get("EDU_TAG2")
                ,p_box.get("EDU_AMT2")
                ,p_box.get("EDU_TAG3")
                ,p_box.get("EDU_AMT3")
                ,p_box.get("EDU_TAG4")
                ,p_box.get("EDU_AMT4")
                ,p_box.get("EDU_TAG5")
                ,p_box.get("EDU_AMT5")
                
                ,p_box.get("GRA_AMT")
                ,p_box.get("HED_AMT")
                
                ,p_box.get("CARD_AMT")
                ,p_box.get("DIR_CARD_AMT")
                ,p_box.get("CASH_AMT")
                ,p_box.get("MARKET_AMT")    
                ,p_box.get("PUBLIC_AMT")
                
                ,p_box.get("CARD_2013_AMT")
                ,p_box.get("CARD_2014_AMT")
                ,p_box.get("CARD_2013_OVER")
                ,p_box.get("CARD_2014_OVER")  
                ,p_box.get("CARD_2015_AMT")  
                ,p_box.get("CARD_2015_FH_OVER")  
                ,p_box.get("CARD_2015_SH_OVER")  

                ,p_box.get("LC1_AMT")   //기부금
                ,p_box.get("LC2_AMT")
                ,p_box.get("LC3_AMT")
                
                ,p_box.get("LH1_AMT")   //주택자금
                ,p_box.get("LH2_AMT")
                ,p_box.get("LH3_AMT")
                ,p_box.get("LH4_AMT")
                ,p_box.get("LH5_AMT")
                ,p_box.get("LH6_AMT")
                ,p_box.get("LH7_AMT")
                ,p_box.get("LH8_AMT")    
                ,p_box.get("LH9_AMT")    
                ,p_box.get("LH10_AMT")    
                ,p_box.get("LH11_AMT")    
                ,p_box.get("LH12_AMT")    
                
                ,p_box.get("SAJU_AMT")     
                
                ,p_box.get("HOL_YN")
                ,p_box.get("INS_TAG")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        //수정하기
        this.updateProcess(Query, bind);
    }    
     
     
    
    
    
    /**
     * 부양 가족 내역중 변경된 사항을 인사 마스터에 수정한다.
     * @param p_box
     * @throws CException
     */
    public void YACA021_UPT_PERSON(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA021_UPT_PERSON");

        //param binding 하기
        Object[] bind = new Object[] {
                 p_box.get("SOU_CNT")
                ,p_box.get("DFM_CNT")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("GOL_CNT70")
                ,p_box.get("TRB_CNT")
                ,p_box.get("WCT_CNT")
                ,p_box.get("CHI_CNT")
                ,p_box.get("ENO_NO")
        };

        //수정하기
        this.updateProcess(Query, bind);
    }
}
