package Ehr.gun.f.gunf070.dao;

import Ehr.common.util.JSPUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNF070DAO extends AbstractDAO {
	/**
	 * GUND060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNF070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 월차관리  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF070_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF070_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {		
				
				p_box.get("DPT_CD"),					
				p_box.get("ENO_NO"),					
				
		};
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	
	/**
	 * 연차발생관리  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF070_SHR_DTL(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF070_SHR_DTL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),

		};

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}		
	
	

	/**
	 * 개인별 근무형태 History 입력
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
		public void GUNF070_SAV(GauceValueObject vo, CBox p_box) throws CException {

			
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF070_INS");

		//System.out.println(p_box);
		//System.out.println(vo);		

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),             // 사번	
				vo.get("ENO_NO"),             // 사번		
				vo.get("JOB_OCC"),            // 근무형태
				p_box.get("vusrid"),		  // 입력자				

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);		
		
	}		
	
	
	
	/**
	 * 개인별 근무형태를 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNF070_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNF070_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				vo.get("JOB_OCC"),            // 근무형태
				vo.get("ENO_NO"),             // 사번				
				
		};

		/** INSERT메소드 호출  **/
		updateProcess(sql, bind);

	}

	
}
