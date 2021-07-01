package purch.common.my;

import java.util.Hashtable;
/**
 * 
 * @author Administrator
 *	Servlet�� ȣ�� �Ұ�� 
 */
public class BaseCommandMap {

	private static Hashtable fCommandHandlerMap;

	private static void setupCommandHandlerMap() {
			addMapCode1();
   	}
   	
   	// �ý��۰��� 
   	private static void addMapCode1() {
		// ���콺 �ڵ� ����
   		
		
		// ���������� 
   		fCommandHandlerMap.put("my010s",			"sales.menu.my.My010S"); // ����������
   		//fCommandHandlerMap.put("my020i",			"sales.menu.my.My020I"); // ��������
   		fCommandHandlerMap.put("my020s",			"sales.menu.my.My020S"); // ����������
   		
   		fCommandHandlerMap.put("my120s",			"sales.menu.my.My120I"); // �븮������ 
   		fCommandHandlerMap.put("my130s",			"sales.menu.my.My130I"); // ���÷��� ���� 
   		 
		fCommandHandlerMap.put("my210s",			"sales.menu.my.My210S"); // ��������
	}
 
   	public static BaseCommand getCommandHandler(String cmd) throws Exception {

   		if (fCommandHandlerMap == null) {
			fCommandHandlerMap = new Hashtable();
			setupCommandHandlerMap();

   		} 
   		
	   return (BaseCommand) Class.forName((String)fCommandHandlerMap.get(cmd)).newInstance();
   }
}
