package Ehr.idt.c.idtc070.dao;


import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class IDTC070DAO extends AbstractDAO {
	
	/**
	 * IDTC070DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * 주간업무보고 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC070_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC070_SHR");

		
		/** 조회 조건(조건1)에 따른 처리 #1  상태**/
		StringBuffer sb1 = new StringBuffer();

		if (p_box.get("ENO_NO").equals("")) {

			sb1.append("AND 1 = 1 \n");
			
		}else {
			
			sb1.append(" AND B.DPT_CD  = ( SELECT DPT_CD FROM ASNHR.T_CM_PERSON WHERE ENO_NO = '"+p_box.get("ENO_NO")+"')");

		}		
		
		
        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {

				sb1.toString(),
        		
        };
        

        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

                JSPUtil.rns(p_box.get("PIS_YMD"))
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	
	
	/**
	 * 주간업무보고 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC070_SHR_DTL(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC070_SHR_DTL");

        String STR_YMD      = JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "");
        String END_YMD      = JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "");
        String CEF_STS      = JSPUtil.rns(p_box.getString("CEF_STS"));


        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {

        };
        

        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
	
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	
	
	
	
    /**
     * 주간업무보고 정보를 저장하는 DAO 메소드.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTC070_INS(GauceValueObject vo, CBox p_box) throws CException {
		
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC070_INS");

        
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		 JSPUtil.rns(vo.get("FEED_BACK"))
                ,JSPUtil.rns(p_box.get("vusrid"))        		
        		,JSPUtil.rns(vo.get("ENO_NO"))
                ,JSPUtil.rns(vo.get("WEEK_NO"))
                ,JSPUtil.rns(vo.get("PLAN_EXE"))    
        };

        this.insertProcess(sql, bind);
        
	}
	
	

    /**
     * 내역을 삭제하는 DAO 메소드.
     * @param p_box
     * @throws CException
     */
	public void IDTC070_DEL_TEMP(CBox p_box) throws CException {
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTC070_DEL_TEMP");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	             JSPUtil.rns(p_box.get("vusrid"))
	    };

	    this.deleteProcess(sql, bind);
	}

}