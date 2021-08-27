package movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

import dao.CancleDao;
import dao.LoginDao;
import dao.MovieInfoDao;
import dao.SignupDao;
import dao.TicketInfoDao;
import dao.TicketingCheckDao;
import vo.MembersVo;
import vo.MovieInfoVo;
import vo.SeatVo;
import vo.TicketInfoVo;
import vo.TicketingCheckVo;

public class Main {
	
	public static String[][] seat = new String[5][9];

	public void resetSeat(){

		for(int i=1; i<5; i++){

			for(int j=1; j<9; j++){

				seat[i][j]="___";
			}
		}
	}
	public void reference(){
		char row = 'A';
		for(int i=1; i<5; i++){
			System.out.print("\n"+row+"열  ");row++;
			for(int j=1; j<9; j++){
				String seat = (this.seat[i][j].equals("___"))?"◻︎":"◼︎";
				System.out.print((j)+seat+"  ");
			}
		}
		System.out.println();
	}
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		LoginDao ldao = LoginDao.getInstance();
		TicketingCheckDao tdao = TicketingCheckDao.getInstance();
		CancleDao cdao = CancleDao.getInstatnce();
	    MovieInfoDao mdao = MovieInfoDao.getInstance();
	    TicketInfoDao idao = TicketInfoDao.getInstance();
	    SignupDao sdao = SignupDao.getInstance();
		MembersVo mvo;
		
		while(true) {
			System.out.println("::: 원하시는 메뉴의 숫자를 입력해주세요. :::");
			System.out.println("1. 회원가입\n2. 로그인\n3. 예매내역조회\n4. 예매취소\n5. 종료");
			System.out.print("숫자입력 >>> ");
			int select = sc.nextInt();
			sc.nextLine();
			
			if (select == 1) {	// 회원가입
				String id = null, password,password2 = null, name, email = null;
				String tel;

				System.out.println(" 영화 그 이상의 감동\n" + "CGV에 오신걸 환영합니다.\n ");

				System.out.println("============== 회원가입 ==============");
		        
				
				while (true) {
					System.out.print("ID를 입력하세요 ===>");
					id = sc.nextLine();
					if (sdao.idcheck(id)) {
						if (id.length() <= 20) {
							System.out.println(id + "은 사용 가능한 아이디 입니다.");
							break;
						} else {
							System.out.println("아이디가 너무 깁니다 다시 확인해주세요.");
						}
					} else {
						System.out.println("::: 사용 중인 ID 입니다. :::");
				
					}
				}
				
				while (true) {
					System.out.print("\n비밀번호를 입력하세요 ===> ");        
					password = sc.nextLine();
						if (password.length() < 10) {
							System.out.print("\n비밀번호를 한번 더 입력하세요 ===> ");
							password2 = sc.nextLine();
								if(password2.length() == password.length()) {
									break;
								} else {
									System.out.println("다르게 입력하셨습니다. 다시 입력해주세요.");
								}
						 }else {
							System.out.println("비밀번호는 10자이하로만 가능합니다.");
							
						}
							}
				
				System.out.print("\n이름을 입력하세요 ===> ");
				name = sc.nextLine();
				System.out.print("\nEmail를 입력하세요 ===> ");
				email = sc.nextLine();
				
				
				while ( true) {
					System.out.print("\n전화번호를 입력하세요 ===> ");
					tel = sc.nextLine();
					if(tel.length() == 13) {
						break;
					}else {
						System.out.println("- 포함한 전화번호 13자리을 입력해주세요");
					}
				}
				
				mvo = MembersVo.builder().id(id).password(password).name(name).email(email)
						.tel(tel).build();
				sdao.insert(mvo);
				
				System.out.println("\n축하합니다 가입이 완료되었습니다.");
				System.out.println("===================================");
				System.out.println("\n" + id + "님 환영합니다!");
				
			
				
				
				
			}	// select1 -end
			
			else if (select == 2) {	// 로그인
				System.out.println("\n::: 로그인을 위해 아이디 및 비밀번호를 입력해주세요. :::");
				System.out.print("아이디 >>> ");
				String id = sc.nextLine();
				System.out.print("비밀번호 >>> ");
				String password = sc.nextLine();
				
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
							
							
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							Connection conn = OracleConnectionUtil.connect();
							String sql = "SELECT * FROM MOVIEINFO";
						    boolean flag = true;
							boolean exit = true;
							Main cr = new Main();
							cr.resetSeat();
							int selectNum, row, col;
							String user = null;
							
							try {
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery(); 
								
							System.out.println("::: 영화정보  :::");
							System.out.println("영화 리스트 입니다.");
							    while(rs.next()) {
								System.out.println("-----------------------------------------------------------------------");
								System.out.println("예매순위:" + rs.getString("movie_num"));
								System.out.print ( rs.getString("movie_name") + "[" + rs.getString("MOVIE_rating") +"/"+
										rs.getString("movie_genre") + "/" + rs.getString("nation") +" "+ rs.getDate("playdate") + "]");
								System.out.print("\t");
								System.out.println("상영시간: " + rs.getString("RUN_TIME"));
								System.out.println("-----------------------------------------------------------------------");
						    }
						    }catch (SQLException e) {
						       System.out.println("SQL 실행에 오류가 발생했습니다. : " + e.getMessage());
						    }
					         	while(true) {
								System.out.println("1.예매  2.취소 ");
								int choice = sc.nextInt();
								sc.nextLine();
								String name;
								if(choice == 1) {			
									while(true) {
										System.out.println("원하시는 영화를 입력해주세요");
										name = sc.nextLine();
										List<MovieInfoVo> list = mdao.getList(name);
										if(list.size() == 0) {
											System.out.println("잘못 입력하셨습니다.");
											continue;
										}
										else {
											for (MovieInfoVo vo : list) {
												System.out.println(vo);
											}
											break;
										}
									}
									StringBuffer str;
									while(true) {
										System.out.println("원하시는 날짜를 입력해주세요");
										String date = sc.nextLine();
										str = new StringBuffer(date);
										str.insert(0, "2021-09-");
										List<TicketInfoVo>list1 = idao.get_List(str.toString(), name);
									if(list1.size() == 0) {
										System.out.println("잘못 입력하셨습니다.");
										continue;
									}else {
										for(TicketInfoVo vo1 : list1) {
											System.out.println(vo1);
										}
									 	break;
									   }
									}
									while(true) {
										System.out.println("원하시는 시간을 입력해주세요");
										String time = sc.nextLine();
						                List<TicketInfoVo>list1 = idao.get_TimeList(str.toString(), name, time);
						                if(list1.size() == 0) {
						                System.out.println("잘못 입력하셨습니다.");
						                      continue;
						                }else {
						                for(TicketInfoVo vo1 : list1) {
						                            System.out.println(vo1);
						                }
										}
						                System.out.println("----------------------------------------------------------");
						                System.out.println("선택하신 영화 정보입니다.");
						                System.out.println("영화제목 :"+ name + "\n날짜:" +str.toString()+ "  영화시간"+ time);
						                System.out.println("----------------------------------------------------------");
										System.out.println("예매를 진행하시겠습니까? 1:네 2:아니오");
										int numm = sc.nextInt();
										if(numm == 1) {
										     do{
											 user = sc.nextLine();
											 System.out.println("좌석 선택창으로 넘어갑니다.");
											 System.out.println("\n1.조회 2.예약 3.종료(기능)");
											 System.out.print("원하시는 서비스를 선택해주세요->");
											 selectNum = sc.nextInt();
											 if(selectNum==1){
												 System.out.println("좌석조회 서비스 입니다.");
												 cr.reference();		 
											 }else if(selectNum==2){
												 System.out.println("인원수를 선택하세요. 최대 인원은 2명까지입니다.");
												 	int peonum = sc.nextInt();
												 	if(peonum==1) {
												    	do{
												    		System.out.print("열을 선택하세요->");
												    		row = sc.nextInt();
												    		System.out.print("행을 선택하세요->");
												    		col = sc.nextInt();
												    		if (seat[row][col].equals("___")) {
												    			seat[row][col] = user;
												    			System.out.println(row+"열"+col+"행 좌석이 예약되었습니다.");
												    			flag = false;
												    		}
												    		else {
												    		System.out.println("이미 예약된 좌석입니다. 다른 좌석을 선택해주세요.");
												    		}
												    	}while(flag);
												    	cr.reference();
												 	}else if(peonum ==2) {						 		
												    	do{					    		
												    		System.out.print("열을 선택하세요->");
												    		row = sc.nextInt();
												    		System.out.print("행을 선택하세요->");
												    		col = sc.nextInt();
												    		if(seat[row][col].equals("___")){
												    		seat[row][col] = user;
												    		System.out.println(row+"열"+col+"행 좌석이 예약되었습니다.");
												    	    }			    		
												    		System.out.print("열을 선택하세요->");
												    		row = sc.nextInt();
												    		System.out.print("행을 선택하세요->");
												    		col = sc.nextInt();
												    		if(seat[row][col].equals("___")){
												    		seat[row][col] = user;
												    		System.out.println(row+"열"+col+"행 좌석이 예약되었습니다.");
												    		break;
												    	}else{
												    		System.out.println("이미 예약된 좌석입니다. 다른 좌석을 선택해주세요.");						    	
												    	}
														}while(flag);
												    	cr.reference();	
												 	}break;	
										     }else if(selectNum==3){
											 System.out.println("서비스를 종료합니다.");break;	 	
											 }
										else if(numm == 2) {
											System.out.println("서비스를 종료합니다.");
											break;
										    }
										 }while(exit);
										}
										}
									}else if(choice==2){
									System.out.println("서비스를 종료합니다.");
									break;
									}
						       }
									
							
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
								while(true) {
									System.out.println("\n::: 상영관 및 좌석정보를 조회하시겠습니까? :::");
									System.out.println("::: 1. 예(해당영화의 movie_code를 기억해 주십시오.)\t\t 2. 아니요. :::");
									System.out.print("번호입력 >>> ");
									int select3 = sc.nextInt();
									sc.nextLine();
									
									if (select3 == 1) {	// 영화코드 입력 및 일치여부 확인
										while(true) {
											System.out.print("영화코드(movie_code) 입력 >>> ");
											String movie_code = sc.nextLine();
											List<SeatVo> s_list = tdao.seat_password_lookup(id, password, movie_code);
											if (s_list.size() == 0) {
												System.out.println("\n::: 영화코드가 일치하지 않습니다. :::");
												break;
											}
											else {
												System.out.println("\n::: 상영관 및 좌석정보를 불어옵니다. :::");
												for (SeatVo vo : s_list) {
													System.out.println(vo);
												}
												System.out.println("");
												break;
											}
										}	// while -end
									}	// select3-1 -end
									else {
										System.out.println("\n::: 메뉴화면으로 돌아갑니다. :::");
										break;
									}	// else -end
								}	// while -end
							}	// else -end
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
									System.out.println("\n::: 취소할 영화의 movie_code를 기억하셔야합니다. :::");
									System.out.println("::: 예매내역을 취소하시겠습니까? :::");
									System.out.println("1. 예\t\t2.아니요");
									System.out.print("번호입력 >>> ");
									int select3 = sc.nextInt();
									sc.nextLine();
									
									if (select3 == 1) {
										System.out.println("\n:::예매번호(movie_code)를 입력해주세요. :::");
										System.out.print("예매번호 >>> ");
										String movie_code = sc.nextLine();
										
										// 예매번호 일치여부 확인
										if (tdao.movie_Check(movie_code, id, password)) {
											System.out.println("예매번호가 올바르지 않습니다.");
										}
										else {	// 예매번호 일치 및 예매취소
											mvo.setMovie_code(movie_code);
											cdao.Cancle(mvo);
											System.out.println("\n::: 예매취소가 완료되었습니다. :::");
										}
										
										System.out.println("::: 로그인 화면으로 돌아갑니다. :::");
									}
									else {	// 예매취소 안하고 돌아가기
										System.out.println("\n::: 로그인 화면으로 돌아갑니다. :::");
									}
								}	// else 예매내역 불러오기 -end
								
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
						while(true) {
							System.out.println("\n::: 상영관 및 좌석정보를 조회하시겠습니까? :::");
							System.out.println("::: 1. 예(해당영화의 movie_code를 기억해 주십시오.)\t\t 2. 아니요. :::");
							System.out.print("번호입력 >>> ");
							int select3 = sc.nextInt();
							sc.nextLine();
							
							if (select3 == 1) {	// 영화코드 입력 및 일치여부 확인
								while(true) {
									System.out.print("영화코드(movie_code) >>> ");
									String movie_code = sc.nextLine();
									List<SeatVo> s_list = tdao.seat_name_lookup(name, id, movie_code);
									if (s_list.size() == 0) {
										System.out.println("\n::: 영화코드가 일치하지 않습니다. :::");
										break;
									}
									else {
										System.out.println("\n::: 상영관 및 좌석정보를 불어옵니다. :::");
										for (SeatVo vo : s_list) {
											System.out.println(vo);
										}
										System.out.println("");
										break;
									}
								}	// while -end
							}	// select3-1 -end
							else {
								System.out.println("\n::: 메뉴화면으로 돌아갑니다. :::");
								break;
							}	// else -end
						}	// while -end
					}	// else -end
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
						if (str.length() >= 3) {
							str.insert(3, "-");
							if (str.length() >= 8) {
								str.insert(8, "-");
							}
						}
						System.out.println("\n::: 예매내역이 없거나 입력정보가 일치하지 않습니다. :::");
						System.out.println("입력한 전화번호 : " + str + "\n");
					}
					else {	// 조회 성공
						System.out.println("\n::: 예매내역을 불러옵니다. :::");
						for (TicketingCheckVo tvo : list) {
							System.out.println(tvo);
						}
						while(true) {
							System.out.println("\n::: 상영관 및 좌석정보를 조회하시겠습니까? :::");
							System.out.println("::: 1. 예(해당영화의 movie_code를 기억해 주십시오.)\t\t 2. 아니요. :::");
							System.out.print("번호입력 >>> ");
							int select3 = sc.nextInt();
							sc.nextLine();
							
							if (select3 == 1) {	// 영화코드 입력 및 일치여부 확인
								while(true) {
									System.out.print("영화코드(movie_code) 입력 >>> ");
									String movie_code = sc.nextLine();
									List<SeatVo> s_list = tdao.seat_tel_lookup(tel, movie_code);
									if (s_list.size() == 0) {
										System.out.println("\n::: 영화코드가 일치하지 않습니다. :::");
										break;
									}
									else {
										System.out.println("\n::: 상영관 및 좌석정보를 불어옵니다. :::");
										for (SeatVo vo : s_list) {
											System.out.println(vo);
										}
										System.out.println("");
										break;
									}
								}	// while -end
							}	// select3-1 -end
							else {
								System.out.println("\n::: 메뉴화면으로 돌아갑니다. :::");
								break;
							}	// else -end
						}
					}	// else 조회성공 -end
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
						while(true) {
							System.out.println("\n::: 상영관 및 좌석정보를 조회하시겠습니까? :::");
							System.out.println("::: 1. 예(해당영화의 movie_code를 기억해 주십시오.)\t\t 2. 아니요. :::");
							System.out.print("번호입력 >>> ");
							int select3 = sc.nextInt();
							sc.nextLine();
							
							if (select3 == 1) {	// 영화코드 입력 및 일치여부 확인
								while(true) {
									System.out.print("영화코드(movie_code) 입력 >>> ");
									String movie_code = sc.nextLine();
									List<SeatVo> s_list = tdao.seat_pay_code_lookup(pay_code, movie_code);
									if (s_list.size() == 0) {
										System.out.println("\n::: 영화코드가 일치하지 않습니다. :::");
										break;
									}
									else {
										System.out.println("\n::: 상영관 및 좌석정보를 불어옵니다. :::");
										for (SeatVo vo : s_list) {
											System.out.println(vo);
										}
										System.out.println("");
										break;
									}
								}	// while -end
							}	// select3-1 -end
							else {
								System.out.println("\n::: 메뉴화면으로 돌아갑니다. :::");
								break;
							}	// else -end
						}	// while -end
					}	// else -end
				}	// select2-3 -end
				
				
				else if (select2 == 4) {	// 뒤로가기
					System.out.println("\n::: 메인화면으로 돌아갑니다. :::");
				}
				
				else {
					System.out.println("\n::: 올바른 값을 입력해주세요. :::");
					System.out.println("입력값 : " + select2);
					System.out.println("");
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
						System.out.println("\n::: 취소할 영화의 movie_code를 기억하셔야합니다. :::");
						System.out.println("::: 예매내역을 취소하시겠습니까? :::");
						System.out.println("1. 예\t\t2.아니요");
						System.out.print("번호입력 >>> ");
						int select2 = sc.nextInt();
						sc.nextLine();
						
						if (select2 == 1) {
							System.out.println("\n:::예매번호(movie_code)를 입력해주세요. :::");
							System.out.print("예매번호 >>> ");
							String movie_code = sc.nextLine();
							
							// 예매번호 일치여부 확인
							if (tdao.movie_Check(movie_code, id, password)) {
								System.out.println("예매번호가 올바르지 않습니다.");
							}
							else {	// 예매번호 일치 및 예매취소
								mvo.setMovie_code(movie_code);
								cdao.Cancle(mvo);
								System.out.println("\n::: 예매취소가 완료되었습니다. :::");
							}
							
							System.out.println("::: 메인화면으로 돌아갑니다. :::\n");
						}
						else {	// 예매취소 안하고 돌아가기
							System.out.println("\n::: 메인화면으로 돌아갑니다. :::\n");
						}
					}	// else 예매내역 불러오기 -end
				}	// else 조회성공 -end
			}	// select4 -end
			
			
			else if (select == 5) {
				System.out.println("프로그램을 종료합니다.");
				break;
			}	// select5 -end
			
			else {
				System.out.println("\n::: 올바른 숫자를 입력해주세요. :::\n");
				continue;
			}	// select5 -end
			
		}	// while -end
		
		sc.close();
	}	// main -end
	

}	// class -end
