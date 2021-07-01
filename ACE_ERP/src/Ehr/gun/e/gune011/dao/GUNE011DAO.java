package Ehr.gun.e.gune011.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class GUNE011DAO extends AbstractDAO {

	/**
	 * GUNE011DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNE011DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ����ٹ����� ��Ȳ ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void GUNE011_SHR(CBox p_box) throws CException {

		String STR_YMD = p_box.get("STR_YMD").replaceAll("-", "");
		String END_YMD = p_box.get("END_YMD").replaceAll("-", "");

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE011_SHR");


		/** ��ȸ ����(����2)�� ���� ó�� #2  ����**/
		StringBuffer sb1 = new StringBuffer();


		//���
		if (p_box.get("GBN").equals("2")) {
			sb1.append("AND    B.APP_YN = 'N'\n");
			sb1.append("AND    B.APP_STATUS LIKE '���%' \n");
		}

		//����Ϸ�
		else if (p_box.get("GBN").equals("3")) {
			sb1.append("AND    B.APP_YN = 'Y'");

		//ALL
		}else {
			
			sb1.append("");
			
		}


		StringBuffer sb3 = new StringBuffer();

		String vusrid = JSPUtil.rns(p_box.get("vusrid"));

		//System.out.println("==================="+p_box);
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vfdname")));	
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vusrnm")));		
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vconame")));			
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vdeptnm")));		
		
		
		if(!p_box.get("vusrid").equals("6060002") && !p_box.get("vusrid").equals("6180001") && !p_box.get("vusrid").equals("2070020")){
			 sb3.append("AND   (A.PENO_NO = '"+ vusrid + "' OR A.ENO_NO = '"+ vusrid +"') \n");
		}else{

		}


		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb1.toString(),
				//sb2.toString(),
				sb3.toString(),

		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("OUR_MAN"),
				STR_YMD,
				END_YMD,
				STR_YMD,
				END_YMD,
		};
		
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	
	
	/**
     * ����ǰ�Ǽ� ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void GUNE011_DEL_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "GUNE011_DEL_01");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO"),
				vo.get("ENO_NO")
		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	


}

