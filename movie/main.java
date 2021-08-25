package movie;

import java.util.List;
import java.util.Scanner;

import Dao.CancleDao;
import Dao.LoginDao;
import Dao.TicketingCheckDao;
import Vo.MembersVo;
import Vo.TicketingCheckVo;

public class Main {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		LoginDao ldao = LoginDao.getInstance();
		TicketingCheckDao tdao = TicketingCheckDao.getInstance();
		CancleDao cdao = CancleDao.getInstatnce();
		MembersVo mvo;
		
		while(true) {
			System.out.println("::: 원하시는 메뉴의 숫자를 입력해주세요. :::");
			System.out.println("1. 회원가입\n2. 로그인\n3. 예매내역조회\n4. 예매취소\n5. 종료");
			System.out.print("숫자입력 >>> ");
			int select = sc.nextInt();
			sc.nextLine();
			
			if (select == 1) {	// 회원가입
				
			}	// select1 -end
			
			else if (select == 2) {	// 로그인
				System.out.println("\n::: 로그인을 위해 아이디 및 비밀번호를 입력해주세요. :::");
				System.out.print("아이디 >>> ");
				String id = sc.nextLine();
				System.out.print("비밀번호 >>> ");
				String password = sc.nextLine();
				
				// 이거 맞는지 질문하기
				mvo = MembersVo.builder().id(id).password(password).build();
				
				if (ldao.idCheck(mvo)) {	// 아이디 가입여부 확인(로그인 실패)
					System.out.println("\n::: 아이디 혹은 비밀번호가 일치하지 않습니다. :::\n");
				}
				else {	// 로그인 성공
					System.out.println("\n::: 로그인이 완료되었습니다. :::");
					
					while(true) {	// 로그인 후 메뉴선택
						System.out.println("\n::: 원하시는 메뉴를 입력해주세요 :::");
						System.out.println("1. 영화예매\n2. 예매내역 조회\n3. 예매취소\n4. 로그아웃");
						System.out.print("숫자입력 >>> ");
						int select2 = sc.nextInt();
						sc.nextLine();
						
						
						
						
						if (select2 == 1) {	// 영화예매
							
						}	// select2-1 -end
						
						
						
						
						
						else if (select2 == 2) {	// 예매내역 조회
							List<TicketingCheckVo> list = tdao.id_Lookup(id, password);
							if (list.size() == 0) {
								System.out.println("\n::: 예매내역이 없습니다. :::");
							}
							else {
								System.out.println("\n::: 예매내역을 불러옵니다. :::");
								for (TicketingCheckVo vo : list) {
									System.out.println(vo);
								}
							}
						}	// select2-2 -end
						
						
						
						
						else if (select2 == 3) {	// 예매취소
							System.out.println("\n::: 본인확인을 위해 비밀번호를 입력해주세요. :::");
							System.out.print("비밀번호 >>> ");
							password = sc.nextLine();
							
							mvo = MembersVo.builder().id(id).password(password).build();
							if (ldao.idCheck(mvo)) {
								System.out.println("\n::: 비밀번호가 일치하지 않습니다. :::");
							}
							else {
								List<TicketingCheckVo> list = tdao.id_Lookup(id, password);
								if (list.size() == 0) {
									System.out.println("\n::: 예매내역이 없습니다. :::");
								}
								else {
									System.out.println("\n::: 예매내역을 불러옵니다. :::");
									for (TicketingCheckVo vo : list) {
										System.out.println(vo);
									}
									
									System.out.println("\n::: 예매내역을 취소하시겠습니까? :::");
									System.out.println("1. 예\t\t2.아니요");
									System.out.print("번호입력 >>> ");
									int select3 = sc.nextInt();
									sc.nextLine();
									
									if (select3 == 1) {
//										Move = MembersVo.builder().password(password).build();
										mvo.setPassword(password);
										cdao.Cancle(mvo);
										System.out.println("\n::: 취소가 완료되었습니다. :::");
									}
									else {
										System.out.println("\n::: 로그인화면으로 돌아갑니다. :::");
									}
								}
								
							}
						}	// select2-3 -end
						
						
						
						else if (select2 == 4) {	// 로그아웃
							System.out.println("\n::: 정상적으로 로그아웃 되었습니다. :::");
							System.out.println("::: 메인화면으로 돌아갑니다. :::\n");
							break;
						}	// select2-4 -end
						
					}	// select2 while -end
				}	// login -end
				
			}	// select2 -end
			
			else if (select == 3) {	// 로그인 없이 예매조회 및 방법선택
				System.out.println("\n::: 내역조회 방법을 선택해주세요 :::");
				System.out.println("1. 이름 및 아이디 입력\n2. 전화번호 입력\n3. 결제코드 입력\n4. 뒤로가기");
				System.out.print("숫자입력 >>> ");
				int select2 = sc.nextInt();
				sc.nextLine();
				
				if (select2 == 1) {	// 이름 및 아이디 입력을 통한 조회
					System.out.println("\n::: 예매조회를 위해 이름 및 아이디를 입력해주세요. :::");
					System.out.print("이름  >>> ");
					String name = sc.nextLine();
					
					System.out.print("아이디 >>> ");
					String id = sc.nextLine();
					
					List<TicketingCheckVo> list = tdao.name_Lookup(name, id);
					if (list.size() == 0) {
						System.out.println("\n::: 예매내역이 없거나 입력정보가 일치하지 않습니다. :::");
						System.out.println("입력한 이름 : " + name);
						System.out.println("입력한 아이디 : " + id + "\n");
					}
					else {
						System.out.println("\n::: 예매내역을 불러옵니다. :::");
						for (TicketingCheckVo vo : list) {
							System.out.println(vo);
						}
						System.out.println("");
					}
				}	// select2-1 -end
				
				else if (select2 == 2) {	// 전화번호를 통한 조회
					System.out.println("\n::: 예매조회를 위해 전화번호를 입력해주세요. :::");
					System.out.print("전화번호 >>> ");
					String tel = sc.nextLine();
					tel = tel.replace("-", "");
					tel = tel.replace(" ", "");
					
					List<TicketingCheckVo> list = tdao.tel_Lookup(tel);
					if (list.size() == 0) {	// 조회 실패
						StringBuffer str = new StringBuffer(tel);
						str.insert(3, "-");
						str.insert(8, "-");
						System.out.println("\n::: 예매내역이 없거나 입력정보가 일치하지 않습니다. :::");
						System.out.println("입력한 전화번호 : " + str + "\n");
					}
					else {	// 조회 성공
						System.out.println("\n::: 예매내역을 불러옵니다. :::");
						for (TicketingCheckVo tvo : list) {
							System.out.println(tvo);
						}
						System.out.println("");
					}
				}	// select2-2 -end
				
				
				
				
				else if (select2 == 3) { // 결재코드를 통한 조회
					System.out.println("\n::: 예매조회를 위해 결제코드를 입력해주세요. :::");
					System.out.print("결제코드 >>> ");
					String pay_code = sc.nextLine();
					
					List<TicketingCheckVo> list = tdao.code_Lookup(pay_code);
					if (list.size() == 0) {	// 조회 실패
						System.out.println("\n::: 입력정보가 일치하지 않습니다. :::");
						System.out.println("입력한 결제코드 : " + pay_code + "\n");
					}
					else {
						System.out.println("\n::: 예매내역을 불러옵니다. :::");
						for (TicketingCheckVo tvo : list) {
							System.out.println(tvo);
						}
						System.out.println("");
					}
				}	// select2-3 -end
				
				
				else if (select2 == 4) {	// 뒤로가기
					System.out.println("\n::: 메인화면으로 돌아갑니다. :::");
				}
				
				else {
					System.out.println("\n::: 올바른 값을 입력해주세요. :::");
					System.out.println("입력값 : " + select2);
				}	// select2-4 -end
				
			}	// select3 -end
			
			
			
			else if (select == 4) {	// 예매취소
				System.out.println("\n::: 본인확인을 위해 아이디 및 비밀번호를 입력해주세요. :::");
				System.out.print("아이디 >>> ");
				String id = sc.nextLine();
				
				System.out.print("비밀번호 >>> ");
				String password = sc.nextLine();
				
				mvo = MembersVo.builder().id(id).password(password).build();
				if (ldao.idCheck(mvo)) {	// 조회 실패
					System.out.println("\n::: 아이디 혹은 비밀번호가 일치하지 않습니다. :::\n");
				}
				else {	// 조회 성공
					List<TicketingCheckVo> list = tdao.id_Lookup(id, password);
					if (list.size() == 0) {
						System.out.println("\n::: 예매내역이 없습니다. :::");
					}
					else {
						System.out.println("\n::: 예매내역을 불러옵니다. :::");
						for (TicketingCheckVo vo : list) {
							System.out.println(vo);
						}
						
						System.out.println("\n::: 예매내역을 취소하시겠습니까? :::");
						System.out.println("1. 예\t\t2.아니요");
						System.out.print("번호입력 >>> ");
						int select2 = sc.nextInt();
						sc.nextLine();
						
						if (select2 == 1) {
							mvo.setPassword(password);
							cdao.Cancle(mvo);
							System.out.println("\n::: 취소가 완료되었습니다. :::");
							System.out.println("::: 메인화면으로 돌아갑니다. :::\n");
						}
						else {
							System.out.println("\n::: 메인화면으로 돌아갑니다. :::\n");
						}
					}	// else 조회성공 -end
					
				}
			}	// select4 -end
			
			
			else if (select == 5) {
				System.out.println("프로그램을 종료합니다.");
				break;
			}	// select5 -end
			
			else {
				System.out.println("올바른 숫자를 입력해주세요.");
				continue;
			}	// select5 -end
			
			
		}	// while -end
		
		
		sc.close();
	}	// main -end
	

}	// class -end
