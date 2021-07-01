package Ehr.cod.e.code040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODE040DAO extends AbstractDAO {
	/**
	 * PIRA090DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE040DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 개인정보 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void CODE040_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 개인정보 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE040_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				            p_box.get("PIS_YY"),   // 년도
							p_box.get("ENO_NO")	   // 사번조건
						   
		};

		//prop.add("BIR_TAG", ColumnProp.COLUMN_TYPE_STRING , 4, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}



          /**
          * 개인소득세율신청
          * @param p_box CBox
          * @throws CException
          */
	    public void CODE040_UPT(CBox p_box, GauceValueObject vo) throws CException {

		     /** 외부 XML에서 SQL을 읽어 온다 **/
		     String sql = XmlSqlUtils.getSQL("cod", "CODE040_UPT");
		     
		     /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
             Object[] bind = new Object[] {
            		    p_box.get("CON_YMD"), 	 //계약일자
            		    p_box.get("SIGN_NM"), 	 //서명
            		    p_box.get("ENO_NO"),    //수정자
            	    	p_box.get("PIS_YY"),     //년도
						p_box.get("ENO_NO")   	 //사원번호
	           	};
		      /** UPDATE메소드 호출  **/
		      updateProcess(sql, bind);
		      
	    }

}
