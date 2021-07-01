/*
package Ehr.yac.a.yaca099.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
*/

package Ehr.yac.a.yaca099.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;
//import Ehr.common.util.//LoggingUtils;

public class YACA099DAO extends AbstractDAO {

	/**
	 * INSB099DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA099DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * JSP를 위해 생성자 추가
     * Transaction 은 처리하지않음
     * @param p_conn
     * @throws CException
     */
    public YACA099DAO(String p_conn) throws CException {
        super(p_conn);
    }

    /**
     * T_AC_FAMILY_TEMP 조회
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA099_SHR_FAM(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_FAM");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_FAM", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    /**
     * T_AC_FAMILY 에 등록된 사항 있는지 체크
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA099_SHR_FAM_CHK(GauceValueObject vo, CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_FAM_CHK");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(vo.get("CET_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_FAM_CHK", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    /**
     * T_AC_FAMILY_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_FAM(CBox p_box, String[][] dsArray, int i) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_FAM");
        
        System.out.println("YACA099_INS_FAM::::PIS_YY"+p_box.get("PIS_YY"));						
		
        
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
        		dsArray[i][0], //PIS_YY            
        		dsArray[i][1], //ENO_NO		  
        		dsArray[i][2], //PIS_YY            
        		dsArray[i][3], //ENO_NO            
        		dsArray[i][4], //NAM_KOR           
        		dsArray[i][5], //CET_NO            
        		dsArray[i][6], //CARD_AMT_NTS      
        		dsArray[i][7], //DIR_CARD_AMT_NTS  
        		dsArray[i][8], //CASH_AMT_NTS      
        		dsArray[i][9], //MARKET_AMT_NTS    
        		dsArray[i][10],//PUBLIC_AMT_NTS    
        		dsArray[i][11],//CARD_2015_FH_AMT  			
        		dsArray[i][12],//CARD_2015_SH_AMT  
        		dsArray[i][13],//CARD_2015_AMT     
        		dsArray[i][14],//CARD_2015_FH_OVER 
        		dsArray[i][15],//CARD_2015_SH_OVER 
        		dsArray[i][16],//CARD_2013_AMT     
        		dsArray[i][17],//CARD_2014_AMT     			
        		dsArray[i][18],//CARD_2013_OVER    
        		dsArray[i][19],//CARD_2014_OVER    
        		dsArray[i][20],//FILE_SEQ        
        		dsArray[i][21],//FROM_CD   
        		dsArray[i][22],//GB_CD   
        		dsArray[i][23],//TOT_AMT       
        		dsArray[i][24],//MARKET_TOT_AMT
        		dsArray[i][25],//TMONEY_TOT_AMT
        		dsArray[i][26],//CS_TOT_AMT       
        		dsArray[i][27],//CS_MARKET_TOT_AMT
        		dsArray[i][28],//CS_TMONEY_TOT_AMT
        		dsArray[i][29],//PR_TOT_AMT       
        		dsArray[i][30],//PR_MARKET_TOT_AMT
        		dsArray[i][31],//PR_TMONEY_TOT_AMT
        		dsArray[i][32],//FT_TOT_AMT       
        		dsArray[i][33],//FT_MARKET_TOT_AMT
        		dsArray[i][34],//FT_TMONEY_TOT_AMT
        		dsArray[i][35],//CF_TOT_AMT       
        		dsArray[i][36],//CF_MARKET_TOT_AMT
        		dsArray[i][37],//CF_TMONEY_TOT_AMT
        		dsArray[i][38],//ENO_NO            
        		dsArray[i][39],//ENO_NO  	
			
        		
        		/*
        		p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("NAM_KOR"),
                vo.get("CET_NO"),               
                vo.get("CARD_AMT_NTS"),
                vo.get("DIR_CARD_AMT_NTS"),
                vo.get("CASH_AMT_NTS"),
                vo.get("MARKET_AMT_NTS"),
                vo.get("PUBLIC_AMT_NTS"),
                vo.get("CARD_2015_FH_AMT"),
                vo.get("CARD_2015_SH_AMT"),
                vo.get("CARD_2015_AMT"),
                vo.get("CARD_2015_FH_OVER"),
                vo.get("CARD_2015_SH_OVER"),
                vo.get("CARD_2013_AMT"),
                vo.get("CARD_2014_AMT"),
                vo.get("CARD_2013_OVER"),
                vo.get("CARD_2014_OVER"),
                vo.get("FILE_SEQ"),
                p_box.get("ENO_NO"),
                p_box.get("ENO_NO")
                */
        };
        
        /*
        System.out.println("PIS_YY"+p_box.get("PIS_YY")        );
        System.out.println("ENO_NO"+p_box.get("ENO_NO")        );
        System.out.println("PIS_YY"+p_box.get("PIS_YY")        );
        System.out.println("ENO_NO"+p_box.get("ENO_NO")        );
        System.out.println("NAM_KOR"+vo.get("NAM_KOR")          );
        System.out.println("CET_NO"+vo.get("CET_NO")           );
        System.out.println("CARD_AMT_NTS"+vo.get("CARD_AMT_NTS")     );
        System.out.println("DIR_CARD_AMT_NTS"+vo.get("DIR_CARD_AMT_NTS") );
        System.out.println("CASH_AMT_NTS"+vo.get("CASH_AMT_NTS")     );
        System.out.println("MARKET_AMT_NTS"+vo.get("MARKET_AMT_NTS")   );
        System.out.println("PUBLIC_AMT_NTS"+vo.get("PUBLIC_AMT_NTS")   );
        System.out.println("CARD_2015_FH_AMT"+vo.get("CARD_2015_FH_AMT") );
        System.out.println("CARD_2015_SH_AMT"+vo.get("CARD_2015_SH_AMT") );
        System.out.println("CARD_2015_AMT"+vo.get("CARD_2015_AMT")    );
        System.out.println("CARD_2015_FH_OVER"+vo.get("CARD_2015_FH_OVER"));
        System.out.println("CARD_2015_SH_OVER"+vo.get("CARD_2015_SH_OVER"));
        System.out.println("CARD_2013_AMT"+vo.get("CARD_2013_AMT")    );
        System.out.println("CARD_2014_AMT"+vo.get("CARD_2014_AMT")    );
        System.out.println("CARD_2013_OVER"+vo.get("CARD_2013_OVER")   );
        System.out.println("CARD_2014_OVER"+vo.get("CARD_2014_OVER")   );
        System.out.println("FILE_SEQ"+vo.get("FILE_SEQ"));  
        System.out.println("ENO_NO"+ p_box.get("ENO_NO"));  
        System.out.println("ENO_NO"+ p_box.get("ENO_NO")); 
        */
       
        System.out.println("YACA099_INS_FAM"+sql);
        
        //LoggingUtils.logQuery("yac.YACA099_INS_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
    
    /**
     * T_AC_FAMILY_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_FAM_TEST(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_FAM_TEST");
        
        System.out.println("YACA099_INS_FAM_TEST::::PIS_YY"+p_box.get("PIS_YY"));						
		
        
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("NAM_KOR"),
                vo.get("CET_NO"),               
                vo.get("CARD_AMT_NTS"),
                p_box.get("ENO_NO"),
                p_box.get("ENO_NO")
        };
        
        
       
        System.out.println("PIS_YY::"+p_box.get("PIS_YY")+"::");
        System.out.println("ENO_NO::"+p_box.get("ENO_NO")+"::");
        System.out.println("NAM_KOR::"+vo.get("NAM_KOR")+"::");
        System.out.println("CET_NO::"+vo.get("CET_NO")+"::");
        System.out.println("CARD_AMT_NTS::"+vo.get("CARD_AMT_NTS")+"::"); 
        System.out.println("ENO_NO::"+ p_box.get("ENO_NO")+"::");  
        System.out.println("ENO_NO::"+ p_box.get("ENO_NO")+"::"); 
       
        System.out.println("YACA099_INS_FAM_TEST"+sql);
        
        //LoggingUtils.logQuery("yac.YACA099_INS_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
    /**
     * T_AC_FAMILY_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_FAM_TEST2(CBox p_box, String[][] dsArray, int i) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_FAM_TEST2");
        
        System.out.println("YACA099_INS_FAM_TEST2::::PIS_YY"+p_box.get("PIS_YY"));						
		
        
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		
        		dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO
               
        };
        
        
       
        System.out.println("dsArray[i][0]::"+dsArray[i][0]+"::");
        System.out.println("dsArray[i][1]"+dsArray[i][1]+"::");
       
       
        System.out.println("YACA099_INS_FAM_TEST2"+sql);
        
        //LoggingUtils.logQuery("yac.YACA099_INS_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
    
    /**
     * T_AC_FAMILY_TEMP 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_FAM_TEMP(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_FAM_TEMP");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(p_box.get("FILE_SEQ"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * T_AC_FAMILY 수정
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_UPT_FAM(CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_UPT_FAM");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("SESSION_ENONO"),
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_UPT_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** UPDATE메소드 호출  **/
        updateProcess(sql, bind);
    }
    

    /**
     * T_AC_INSURANCE_TEMP 조회
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA099_SHR_INS(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_INS");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_INS", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    /**
     * T_AC_INSURANCE_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_INS(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_INS");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("CET_NO"),
                vo.get("NAM_KOR"),
                vo.get("INS_CET"),
                vo.get("INS_NM"),
                vo.get("INS_GBN"),
                vo.get("INS_AMT"),
                vo.get("FILE_SEQ"),
                p_box.get("SESSION_ENONO"),
                p_box.get("SESSION_ENONO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_INS_INS", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
    /**
     * T_AC_INSURANCE 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_INS(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_INS");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(p_box.get("FILE_SEQ"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_INS", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    
    /**
     * T_AC_MEDICAL_TEMP 조회
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA099_SHR_MED(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_MED");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_MED", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    /**
     * T_AC_MEDICAL_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_MED(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_MED");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("SUM_AMT"),
                vo.get("COM_NO"),
                vo.get("COM_NM"),
                vo.get("CET_NO"),
                vo.get("CARD_AMT"),
                vo.get("MED_CD"),
                vo.get("LENS_YN"),
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("FILE_SEQ"),
                p_box.get("SESSION_ENONO"),
                p_box.get("SESSION_ENONO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_INS_MED", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
    /**
     * T_AC_MEDICAL_TEMP 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_MED(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_MED");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(vo.get("COM_NO"))
                ,JSPUtil.rns(vo.get("CET_NO"))
                ,JSPUtil.rns(p_box.get("FILE_SEQ"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_MED", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * T_AC_MEDICAL 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_MED_02(CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_MED_02");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(p_box.get("MY_CET"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_MED_02", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * T_AC_PENSION_TEMP 조회
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA099_SHR_PEN(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_PEN");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_PEN", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }    
    
    /**
     * T_AC_PENSION_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_PEN(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_PEN");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("PEN_TYPE_CD"),
                vo.get("PEN_TYPE_NM"),
                vo.get("PEN_GUBUN_CD"),
                vo.get("PEN_GUBUN_NM"),
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("PEN_TYPE_CD"),
                vo.get("PEN_GUBUN_CD"),
                vo.get("ABA_CD"),
                vo.get("ABA_NM"),
                vo.get("ACC_NO"),
                vo.get("YEAR_SEQ"),
                vo.get("AMOUNT"),
                vo.get("NTS_YN"),
                vo.get("CET_NO"),
                vo.get("FILE_SEQ"),
                p_box.get("SESSION_ENONO"),
                p_box.get("SESSION_ENONO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_INS_PEN", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    

    /**
     * T_AC_PENSION_TEMP 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_PEN(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_PEN");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(vo.get("PEN_TYPE_CD"))
                ,JSPUtil.rns(vo.get("PEN_GUBUN_CD"))
                ,JSPUtil.rns(vo.get("ROW_NUM"))
                ,JSPUtil.rns(p_box.get("FILE_SEQ"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_PEN", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * T_AC_PENSION 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_PEN_02( CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_PEN_02");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_PEN_02", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * T_AC_DONATION_TEMP 조회
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA099_SHR_DON(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_DON");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_DON", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
    }
    
    /**
     * T_AC_DONATION_TEMP 저장
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_INS_DON(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_INS_DON");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                vo.get("REL_CD"),
                vo.get("COM_NM"),
                vo.get("COM_NO"),
                vo.get("SUM_AMT"),
                vo.get("FAM_NM"),
                vo.get("FAM_NO"),
                vo.get("NTS_YN"),           
                vo.get("FILE_SEQ"),
                p_box.get("SESSION_ENONO"),
                p_box.get("SESSION_ENONO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_INS_DON", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** INSERT메소드 호출  **/
        insertProcess(sql, bind);
    }
    
    /**
     * T_AC_DONATION_TEMP 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_DON(GauceValueObject vo, CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_DON");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(vo.get("REL_CD"))                
                ,JSPUtil.rns(vo.get("COM_NO"))
                ,JSPUtil.rns(vo.get("FAM_NO"))
                ,JSPUtil.rns(p_box.get("FILE_SEQ"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_DON", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * T_AC_DONATION 삭제
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA099_DEL_DON_02(CBox p_box) throws CException {

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_DEL_DON_02");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
                ,JSPUtil.rns(p_box.get("MY_CET"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_DEL_DON_02", p_box.get("SESSION_ENONO"), sql, bind);
        
        /** DELETE메소드 호출  **/
        deleteProcess(sql, bind);
    }
    
    /**
     * 연말정산 부양가족사항으로 이미 등록되었는지 조회
     * @param p_box
     * @throws CException
     */
    public void YACA099_SHR_CHK(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_SHR_CHK");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //LoggingUtils.logQuery("yac.YACA099_SHR_CHK", p_box.get("SESSION_ENONO"), Query, bind);
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    
    /**
     * T_AC_FAMILY_TEMP 조회
     * @param p_box
     * @throws CException
     * 
     * 
     */
    /**
     * 2015년도 연말정산내역 을 가져온다.
     * @param p_box
     * @throws CException
     */
   
    
    public GauceDataSet YACA099_FAM_UPT_SHR(CBox p_box) throws CException {
    	
    	System.out.println("YACA099_FAM_UPT_SHR");
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA099_FAM_UPT_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        //값 보내고 DataSet 가져오기
        return this.selectProcess(Query, bind, prop);
        
        
    }
    
    
    public void YACA099_RETACC_CARD_UPT(CBox p_box) throws CException {

    	
    	System.out.println("YACA099_RETACC_CARD_UPT");
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_RETACC_CARD_UPT");
        
        System.out.println("YACA099_RETACC_CARD_UPT1");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO"),
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_UPT_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        System.out.println("YACA099_RETACC_CARD_UPT2"+ sql);
        
        /** UPDATE메소드 호출  **/
        updateProcess(sql, bind);
        
        System.out.println("YACA099_RET_CARD_UPT_ END ");
    }
    
    
    public void YACA099_FAMILY_TEMP_LOCK_UPT(CBox p_box) throws CException {

    	
    	System.out.println("YACA099_FAMILY_TEMP_LOCK_UPT");
    	
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA099_FAMILY_TEMP_LOCK_UPT");
        
        System.out.println("YACA099_RETACC_CARD_UPT1");
                
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                p_box.get("PIS_YY"),
                p_box.get("ENO_NO")
        };
        
        //LoggingUtils.logQuery("yac.YACA099_UPT_FAM", p_box.get("SESSION_ENONO"), sql, bind);
        
        System.out.println("YACA099_FAMILY_TEMP_LOCK_UPT"+ sql);
        
        /** UPDATE메소드 호출  **/
        updateProcess(sql, bind);
        
        System.out.println("YACA099_FAMILY_TEMP_LOCK_UPT END ");
    }
    
    
 public void YACA099_FAMILY_CARD_UPT(CBox p_box, String[][] dsArray, int i) throws CException {

    	
	 /** 외부 XML에서 SQL을 읽어 온다 **/
     String sql = XmlSqlUtils.getSQL("yac", "YACA099_FAMILY_CARD_UPT");
     
     System.out.println("YACA099_FAMILY_CARD_UPT::::PIS_YY"+p_box.get("PIS_YY"));						
    
     /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
     Object[] bind = new Object[] {
     		
    		 dsArray[i][0], //
    		 dsArray[i][1], //
    		 dsArray[i][2], //
    		 dsArray[i][3], //
    		 dsArray[i][4], //
    		 dsArray[i][5], //
    		 dsArray[i][6], //
    		 dsArray[i][7], //
    		 dsArray[i][8], //
    		 dsArray[i][9], //
    		 dsArray[i][10],//
    		 dsArray[i][11],//		
    		 dsArray[i][12],//
    		 dsArray[i][13],//
    		 dsArray[i][14],//
    		 dsArray[i][15],//
    		 dsArray[i][16],//
     		
     };
     
        System.out.println("dsArray[i][0];"+dsArray[i][0]);
		System.out.println("dsArray[i][1];"+dsArray[i][1]);
		System.out.println("dsArray[i][2];"+dsArray[i][2]);
		System.out.println("dsArray[i][3];"+dsArray[i][3]);
		System.out.println("dsArray[i][4];"+dsArray[i][4]);
		System.out.println("dsArray[i][5];"+dsArray[i][5]);
		System.out.println("dsArray[i][6];"+dsArray[i][6]);
		System.out.println("dsArray[i][7];"+dsArray[i][7]);
		System.out.println("dsArray[i][8];"+dsArray[i][8]);
		System.out.println("dsArray[i][9];"+dsArray[i][9]);
		System.out.println("dsArray[i][10];"+dsArray[i][10]);
		System.out.println("dsArray[i][11];"+dsArray[i][11]);
		System.out.println("dsArray[i][12];"+dsArray[i][12]);
		System.out.println("dsArray[i][13];"+dsArray[i][13]);
		System.out.println("dsArray[i][14];"+dsArray[i][14]);
		System.out.println("dsArray[i][15];"+dsArray[i][15]);
		System.out.println("dsArray[i][16];"+dsArray[i][16]);
        System.out.println("updateProcess"+sql);		
        
      
        /** UPDATE메소드 호출  **/
        updateProcess(sql, bind);
        
      
    }
    
}
