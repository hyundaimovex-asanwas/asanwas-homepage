package purch.common.my;

import java.util.Hashtable;
/**
 * 
 * @author Administrator
 *	Servlet를 호출 할경우 
 */
public class BaseCommandMap {

	private static Hashtable fCommandHandlerMap;

	private static void setupCommandHandlerMap() {
			addMapCode1();
   	}
   	
   	// 시스템관리 
   	private static void addMapCode1() {
		// 가우스 코드 생성
   		
		
		// 마이페이지 
   		fCommandHandlerMap.put("my010s",			"sales.menu.my.My010S"); // 받은편지함
   		//fCommandHandlerMap.put("my020i",			"sales.menu.my.My020I"); // 편지쓰기
   		fCommandHandlerMap.put("my020s",			"sales.menu.my.My020S"); // 보낸편지함
   		
   		fCommandHandlerMap.put("my120s",			"sales.menu.my.My120I"); // 대리점문의 
   		fCommandHandlerMap.put("my130s",			"sales.menu.my.My130I"); // 컨플레임 관리 
   		 
		fCommandHandlerMap.put("my210s",			"sales.menu.my.My210S"); // 공지사항
	}
 
   	public static BaseCommand getCommandHandler(String cmd) throws Exception {

   		if (fCommandHandlerMap == null) {
			fCommandHandlerMap = new Hashtable();
			setupCommandHandlerMap();

   		} 
   		
	   return (BaseCommand) Class.forName((String)fCommandHandlerMap.get(cmd)).newInstance();
   }
}
