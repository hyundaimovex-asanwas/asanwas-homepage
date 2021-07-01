package Ehr.pir.i.piri010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRI010DAO extends AbstractDAO {
	/**
	 * SCHA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRI010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}


	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void PIRI010_SHR_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"piri010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	
	/**
	 * 부서 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void PIRI010_SHR_01(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRI010_SHR_01");

		/** 재직 구분에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		
		if ( p_box.get("END_YN").equals("1") ) {
			sb.append("AND    (RET_YMD IS NULL OR RET_YMD >= SYSDATE) \n");
		}else{
			sb.append("");
		}

		//System.out.print(p_box);

		//본부장권한 추가함. 해당본부장만 보이게, 김영현 전무님 겸직으로 T/F도 보이도록
		StringBuffer sb3 = new StringBuffer();

		if ( !p_box.get("SESSION_ROLE_CD").equals("1001") && !p_box.get("SESSION_ROLE_CD").equals("1002")
				&& p_box.get("SESSION_ROLE_CD").equals("2021") ) {

			if ( p_box.get("SESSION_ENONO").equals("1990016") ) {
				sb3.append("AND   (HEAD_CD = 'K000' OR DPT_CD = 'A480') ");

			}else if ( p_box.get("SESSION_ENONO").equals("1990017") ) {
					sb3.append("AND   1=1 ");							
					
			}else{
				
				sb3.append("AND    HEAD_CD = '"+p_box.get("SESSION_HEADCD")+"'");
			}			

			
		}

		//본부장권한 추가함. 해당본부장만 보이게
		StringBuffer sb4 = new StringBuffer();

		if ( !p_box.get("SESSION_ROLE_CD").equals("1001") && !p_box.get("SESSION_ROLE_CD").equals("1002")
				&& p_box.get("SESSION_ROLE_CD").equals("2022") && !p_box.get("SESSION_ENONO").equals("2070037")) {
			sb4.append("AND    DPT_CD = '"+p_box.get("SESSION_DPTCD")+"'");

		}else if ( p_box.get("SESSION_ENONO").equals("2070037") ) {
		
			sb4.append("AND    HEAD_CD = '"+p_box.get("SESSION_HEADCD")+"'");		
		}
	
		
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb3.toString(),
				sb4.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_GUBUN")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 사원 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void PIRI010_SHR_02(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRI010_SHR_02");

		/** 재직 구분에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		if ( p_box.get("END_YN").equals("1") ) {
			sb.append("AND    RET_YMD IS NULL \n");
		}else{
			sb.append("");
		}


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_GUBUN"),
				p_box.get("DPT_CD")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	

	public void PIRI010_SHR_DUTY(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRI010_SHR_DUTY");




		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}	

}
