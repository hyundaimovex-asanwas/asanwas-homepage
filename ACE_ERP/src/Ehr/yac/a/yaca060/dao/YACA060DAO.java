package Ehr.yac.a.yaca060.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA060DAO extends AbstractDAO {

	/**
	 * YACA060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 연금저축공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA060_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		//prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);

		//prop.add("PEN_TYPE_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("PEN_TYPE_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("PEN_GUBUN_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("PEN_GUBUN_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_KEY);

		//prop.add("ABA_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("ABA_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("ACC_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("YEAR_SEQ", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("AMOUNT", ColumnProp.COLUMN_TYPE_DECIMAL, 12, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("NTS_YN", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 연금저축공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA060_SHR_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_SHR_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 연금저축공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA060_SHR_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_SHR_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * 연금저축공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_INS(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO				
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO	
				dsArray[i][2],//PEN_TYPE_CD
				dsArray[i][3],//PEN_TYPE_NM				
				dsArray[i][4],//PEN_GUBUN_CD
				dsArray[i][5],//PEN_GUBUN_NM
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO					
				dsArray[i][2],//PEN_TYPE_CD				
				dsArray[i][4],//PEN_GUBUN_CD				
				dsArray[i][7],//ABA_CD
				dsArray[i][8],//ABA_NM
				dsArray[i][9].replaceAll("-", ""),//ACC_NO					
				dsArray[i][10],//YEAR_SEQ
				dsArray[i][11],//AMOUNT
				dsArray[i][12],//NTS_YN				
				p_box.get("SESSION_ENONO"),					//입력자
				p_box.get("SESSION_ENONO")					//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	
	/**
	 * 연금저축공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_INS_14(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_INS_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO				
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO	
				dsArray[i][2],//PEN_TYPE_CD
				dsArray[i][3],//PEN_TYPE_NM				
				dsArray[i][4],//PEN_GUBUN_CD
				dsArray[i][5],//PEN_GUBUN_NM
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO					
				dsArray[i][2],//PEN_TYPE_CD				
				dsArray[i][4],//PEN_GUBUN_CD				
				dsArray[i][7],//ABA_CD
				dsArray[i][8],//ABA_NM
				dsArray[i][9].replaceAll("-", ""),//ACC_NO					
				dsArray[i][10],//AMOUNT
				dsArray[i][11],//NTS_YN
                p_box.get("vusrid"), //입력자
                p_box.get("vusrid")  //수정자
                
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * 연금저축공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_INS_15(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_INS_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO				
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO	
				dsArray[i][2],//PEN_TYPE_CD
				dsArray[i][3],//PEN_TYPE_NM				
				dsArray[i][4],//PEN_GUBUN_CD
				dsArray[i][5],//PEN_GUBUN_NM
				dsArray[i][0],//PIS_YY
				dsArray[i][1],//ENO_NO					
				dsArray[i][2],//PEN_TYPE_CD				
				dsArray[i][4],//PEN_GUBUN_CD				
				dsArray[i][7],//ABA_CD
				dsArray[i][8],//ABA_NM
				dsArray[i][9].replaceAll("-", ""),//ACC_NO					
				dsArray[i][10],//AMOUNT
				dsArray[i][11],//NTS_YN
				dsArray[i][12],//IN_GB
                p_box.get("vusrid"), //입력자
                p_box.get("vusrid")  //수정자
                
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * 연금저축공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속녀도
				vo.get("ENO_NO"),								//사원번호
				vo.get("PEN_TYPE_CD"),							//연금저축유형
				vo.get("PEN_GUBUN_CD"),							//연금저축구분
				vo.get("ABA_CD"),	
				vo.get("ACC_NO"),											
				vo.get("SEQ_NO")
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	public void YACA060_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),								//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	
	
	
	/**
	 * 연금저축공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_DEL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),										//귀속년도
				vo.get("ENO_NO"),									//사원번호
				vo.get("PEN_TYPE_CD"),							//연금저축유형
				vo.get("PEN_GUBUN_CD"),							//연금저축구분
				vo.get("ABA_CD"),	
				vo.get("ACC_NO")	,
				vo.get("SEQ_NO")				
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * 연금저축공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_DEL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),										//귀속년도
				vo.get("ENO_NO"),									//사원번호
				vo.get("PEN_TYPE_CD"),							//연금저축유형
				vo.get("PEN_GUBUN_CD"),							//연금저축구분
				vo.get("ABA_CD"),	
				vo.get("ACC_NO")	,
				vo.get("SEQ_NO")				
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	public void YACA060_DEL2_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL2_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),								//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	
	
	public void YACA060_DEL2_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_DEL2_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),								//귀속년도
				vo.get("ENO_NO"),								//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	
	
	
	/**
	 * 연금저축공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_FAM(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_FAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	
	/**
	 * 연금저축공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_FAM_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_FAM_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	

	/**
	 * 연금저축공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_ACC(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_ACC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	/**
	 * 연금저축공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_ACC_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_ACC_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * 연금저축공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA060_UPT_ACC_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA060_UPT_ACC_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	

	
}
