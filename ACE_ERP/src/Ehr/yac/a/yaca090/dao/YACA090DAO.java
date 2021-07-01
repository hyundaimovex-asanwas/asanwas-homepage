package Ehr.yac.a.yaca090.dao;

//2015.01.27 이동훈 중간에 driver 빼줬더니만 에러 사라짐... 뭐였더라..흠...
//import Ehr.yac.a.yaca090.wrk.YACA090WRK;
import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class YACA090DAO extends AbstractDAO {

    /**
     * YACA090DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
     * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
     * @param p_conn    Connection
     * @param p_tr      TrBox
     * @throws CException
     */
    public YACA090DAO(String p_conn, TrBox p_tr) throws CException {
        /** SuperClass의 생성자 호출 **/
        super(p_conn, p_tr);
    }

    /**
     * JSP를 위해 생성자 추가
     * Transaction 은 처리하지않음
     * @param p_conn
     * @throws CException
     */
    public YACA090DAO(String p_conn) throws CException {
        super(p_conn);
    }

    /**
     * 작업 현황 검색
     * @param p_box
     * @throws CException
     */
    public void YACA090_SHR_LOG_DS(CBox p_box) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("yac", "YACA090_SHR_LOG");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("PIS_YY"))
                ,JSPUtil.rns(p_box.get("PIS_MM"))
        };

        prop.add("PRO_STS_MSG", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        /**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
        this.selectProcessFirstRow(Query, bind, prop);
    }

    /**
     * 대상자선정(년도마다 다르게 한다.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_02(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_02_"+agn_yy+".SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";

        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                             String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                  String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        //this.executeProcedure(sql, bind, null);
        CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * 정산계산작업(년도마다 다르게 한다.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_03(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_03_2014.SF_INS_T_AC_RETACC_14(?, ?, '8', ?, ?, ?, ?, ?) }";

        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("vo ==========================================="+vo);        
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                 String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * 정산계산작업(년도마다 다르게 한다.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_03_142(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_03_2014_2.SF_INS_T_AC_RETACC_142(?, ?, '8', ?, ?, ?, ?, ?) }";

        System.out.println("p_box   =========================================== " + p_box);	
    	System.out.println("vo ==========================================="+vo);        
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                           String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }    
    
    /**
     * 정산계산작업(년도마다 다르게 한다.)
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_03_15(CBox p_box, GauceValueObject vo, String agn_yy) throws CException {

        /** 금액·세액계산 패키지 실행  **/
       // String sql = "{ call PKG_XF_YACA090_INS_03_2015.SF_INS_T_AC_RETACC_15(?, ?, '8', ?, ?, ?, ?, ?) }";
        String sql = "{ call PKG_XF_YACA090_INS_03_2015.SF_INS_T_AC_RETACC_15(?, ?, '8', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";

        System.out.println("p_box   =========================================== " + p_box);	
    	System.out.println("vo ==========================================="+vo);          
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                           String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) }, //작업완료메세지
                
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "PRO_CNT",      "0",                                 String.valueOf(OracleTypes.VARCHAR) } //처리인원
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }    
    
    
    
    
    /**
     * 작업종료
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_04(CBox p_box, GauceValueObject vo) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_04.SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";

        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                 String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                      String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };


        /** EXECUTEPROCEDURE 메소드 호출  **/
        //this.executeProcedure(sql, bind, null);
        CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * 대상자선정 재작업
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_05(CBox p_box, GauceValueObject vo) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_05.SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";

        String SES_ENO_NO = p_box.get("SESSION_ENONO");        
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                 String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                      String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        //this.executeProcedure(sql, bind, null);
        CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * 정산계산작업 재작업
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_06(CBox p_box, GauceValueObject vo) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_06.SF_INS_T_AC_RETACC(?, ?, '8', ?, ?, ?, ?, ?) }";   
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");          
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                             String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                  String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }

    /**
     * 정산계산작업 재작업
     * @param p_box
     * @param vo    GauceValueObject
     * @throws CException
     */
    public void YACA090_INS_06_142(CBox p_box, GauceValueObject vo) throws CException {

        /** 금액·세액계산 패키지 실행  **/
        String sql = "{ call PKG_XF_YACA090_INS_06_2.SF_INS_T_AC_RETACC_142(?, ?, '8', ?, ?, ?, ?, ?) }";   
        
        String SES_ENO_NO = p_box.get("SESSION_ENONO");          
        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {

                {"IN",      "",             JSPUtil.rns(vo.get("PIS_YY")),                  ""                                  },//년
                {"IN",      "",             JSPUtil.rns(vo.get("PIS_MM")),                  ""                                  },//월
                {"IN",      "",             JSPUtil.rns(SES_ENO_NO),        ""                                  				},//작업자

                {"IN/OUT",  "PRO_CNT",      "0",                                            String.valueOf(OracleTypes.VARCHAR) },//처리인원
                {"IN/OUT",  "ERR_CNT",      "0",                                             String.valueOf(OracleTypes.VARCHAR) },//예외인원
                {"IN/OUT",  "PRO_STS",      "PRO_STS",                                  String.valueOf(OracleTypes.VARCHAR) },//작업단계
                {"IN/OUT",  "PRO_STS_MSG",  "PRO_STS_MSG",                       String.valueOf(OracleTypes.VARCHAR) } //작업완료메세지
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        this.executeProcedure(sql, bind, null);
        //CBox box = (CBox)this.executeProcedure(sql, bind, null);

    }    
    
       
}
