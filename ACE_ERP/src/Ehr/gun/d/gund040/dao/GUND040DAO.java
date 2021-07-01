package Ehr.gun.d.gund040.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUND040DAO extends AbstractDAO {
	/**
	 * GUND040DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUND040DAO(String p_conn, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);

	}

	/**
	 * ���κ� ���� ���� ��Ȳ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void GUND040_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ� ���� ���� ��Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND040_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				
				p_box.get("PIS_YY"),	    			// �ش��
				p_box.get("PIS_MM_STR"),	    // �ش��(����)
				p_box.get("PIS_MM_END"),		// �ش��(����)
				p_box.get("ENO_NO"),				// ���
				p_box.get("PIS_YY"),	    			// �ش��
				p_box.get("PIS_MM_STR"),	    // �ش��(����)
				p_box.get("PIS_MM_END"),		// �ش��(����)
				p_box.get("ENO_NO"),				// ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * ���κ� ���� ��Ȳ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUND040_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ��ް������Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND040_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    			// �⵵
				p_box.get("ENO_NO"),				// ���
		};

        prop.add("YRP_CNT"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("YRP_ATT_H"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_YRP"  	,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}


	/**
	 * ���κ� ���� ��Ȳ SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUND040_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� ���κ��ް������Ȳ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND040_SHR_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),				// ���
		};


		/** FirstRow�޼ҵ� ȣ�� **/
		return this.selectProcess(sql, bind, prop);
	}	
	
	/**
	 * ���κ�����������Ȳ ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
		public void GUND040_SAV(CBox p_box, String[][] dsArray, int i) throws CException {


		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND040_SAV");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				
				dsArray[i][34],//					
				dsArray[i][35],//
				dsArray[i][0],//ENO_NO
				dsArray[i][1],//
				dsArray[i][2],//
				dsArray[i][3],//		
				dsArray[i][4],//
				dsArray[i][5],//
				
                p_box.get("vusrid"), //�Է���
                p_box.get("vusrid")  //������				

		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
		
	}	
	
	
		/**
		 * ���κ�����������Ȳ ����
		 * @param p_box
		 * @param vo		GauceValueObject
		 * @throws CException
		 */
			public void GUND040_UPT_END(CBox p_box) throws CException {


			/** �ܺ� XML���� SQL�� �о� �´� **/
			String sql = XmlSqlUtils.getSQL("gun", "GUND040_UPT_END");

			/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
			Object[] bind = new Object[] {

	                p_box.get("SUBMIT_TAG"), //
	                p_box.get("PIS_YY"), //		                
	                p_box.get("ENO_NO"), //		
	                

			};

			/** UPDATE�޼ҵ� ȣ��  **/
			updateProcess(sql, bind);
			
		}			
		
	/**
	 * ���κ�����������Ȳ ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUND040_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND040_UPT");

		int ATT_H = 0;
		
		for(int j=1;j<=31;j++){
			
			if(vo.get("AT"+j+"_CD").equals("H")){
				
				ATT_H = ATT_H + 1;

			}		
		}
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {

				
				vo.get("AT1_CD"),
				vo.get("AT2_CD"),
				vo.get("AT3_CD"),
				vo.get("AT4_CD"),
				vo.get("AT5_CD"),
				vo.get("AT6_CD"),
				vo.get("AT7_CD"),
				vo.get("AT8_CD"),
				vo.get("AT9_CD"),
				vo.get("AT10_CD"),
				vo.get("AT11_CD"),
				vo.get("AT12_CD"),
				vo.get("AT13_CD"),
				vo.get("AT14_CD"),
				vo.get("AT15_CD"),
				vo.get("AT16_CD"),
				vo.get("AT17_CD"),
				vo.get("AT18_CD"),
				vo.get("AT19_CD"),
				vo.get("AT20_CD"),
				vo.get("AT21_CD"),
				vo.get("AT22_CD"),
				vo.get("AT23_CD"),
				vo.get("AT24_CD"),
				vo.get("AT25_CD"),
				vo.get("AT26_CD"),
				vo.get("AT27_CD"),
				vo.get("AT28_CD"),
				vo.get("AT29_CD"),
				vo.get("AT30_CD"),
				vo.get("AT31_CD"),
				Integer.toString(ATT_H),
				p_box.get("vusrid"),
				vo.get("PIS_YYMM").substring(0, 4),
				vo.get("PIS_YYMM").substring(5, 7),
				vo.get("ENO_NO")

		};


		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
		
	}

		public void GUND040_DEL(CBox p_box, GauceValueObject vo) throws CException {

			/** �ܺ� XML���� SQL�� �о� �´� **/
			String sql = XmlSqlUtils.getSQL("gun", "GUND040_DEL");

			/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
			Object[] bind = new Object[] {
					vo.get("PIS_YYMM").substring(0, 4),
					vo.get("ENO_NO"),								//�����ȣ
			};

			/** DELETE�޼ҵ� ȣ��  **/
			deleteProcess(sql, bind);
		}			
		

}
