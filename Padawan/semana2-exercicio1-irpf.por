programa
{
	inclua biblioteca Tipos --> tipo // o símbolo --> diz que a biblioteca usará o nome atribuído aṕos '-->' para chamar as funções exclusivas desta biblioteca
	inclua biblioteca Texto --> texto
	inclua biblioteca Matematica --> mat
	inclua biblioteca Util --> util

	const cadeia PROGRAMA = "IRPF Cálculo "
	const cadeia DATA_PATCH = "21/08/2021 - 16:58"
	const real VERSAO = 0.01
	const cadeia RELEASE = "beta"
	const cadeia AUTOR = "HakamRashid"
	//
	// fez uma modificação no código? então acrescente seu nome.
	// acrescente uma linha dentro da matriz seguindo o exemplo fornecido
	// verifique se cada linha termina com uma vírgula, apenas a última linha deve terminar com chave 
	// { [nome], [email], [link social], [grupo, empresa, escola ou organização] }
	// se não quiser preencher um dado apenas escreva ""
	// exemplo: { "apelido", "", "" }
	cadeia matrix[][] = {
		{ "HakamRashid", "victorthales.draco@gmail.com", "https://github.com/HakamRashid", "Univesp" }
	}
	
	const cadeia LINK = "https://github.com/HakamRashid/tools.git"
	const cadeia ORG = "Univesp - Aula de Pensamento Computacional"
	
	logico RegraAtual = verdadeiro
	// variável de controle que impede o programa de seguir caso não haja informações válidas  
	logico execucao = falso
	// esta variável termina a execução do programa caso o usuário erre ao fornecer dados corretos
	// o controle de erros pode ser ativado inserindo um valor maior que 0 na variável 'erros_permitidos'
	// se erros_permitidos = 3 o programa encerrará a execução quando o usuário fornecer dados inválidos 3 vezes consecutivas 
	// para a mesma entrada
	inteiro erros_permitidos = 0
	inteiro erros_do_usuario = -1
	real salarioBruto = 0.0
	real salarioBase = 0.0
	real descontosTotais = 0.0
	real parcelaDeducao = 0.0
	real MatrizINSS[][] = {
		{ 1045.00, 0.075 },
		{ 2089.60, 0.09 },
		{ 3134.40, 0.12 },
		{ 6101.06, 0.14 }
	}
	real MatrizIRPF[][] = {
		{ 1903.99, 2826.65, 0.075, 142.80 },
		{ 2826.66, 3751.05,  0.15, 354.80 },
		{ 3751.06, 4664.68, 0.225, 636.13 },
		{ 4664.69,     0.0, 0.275, 869.36 }
	}
	const real Desconto_Dependentes = 189.59

	funcao inicio()
	{
		cadeia opcao1 = ""
		inteiro opcaoregra = 0

		limpa()
		mensagemInicio()
		separador()
		Cabecalho()
		se( erros_permitidos > 0 ){ erros_do_usuario = 0 }
		
		enquanto( execucao != verdadeiro e erros_do_usuario < erros_permitidos ){
			opcao1 = perguntaInicial()
			ControleDeErro()
			
			// Verifica se a resposta a perguntaInicial é do tipo inteiro e se é '1'ou '2' senão pede novamente que o usuário insira uma opção
			se( tipo.cadeia_e_inteiro( opcao1, 10 ) == falso ){
				escreva("Digite uma opção numérica ( 1 ou 2 )")
				execucao = falso
				se( erros_permitidos > 0){ erros_do_usuario++ }
			} senao {
				opcaoregra = tipo.cadeia_para_inteiro( opcao1, 10 )
				escolha (opcaoregra){
				caso 1: // Usará a nova regra para realizar o cálculo do IRPF 
					RegraAtual = verdadeiro
					execucao = verdadeiro
					separador()
					escreva( "usando regras atuais\n")
					pare
				caso 2: // Usará a regra antiga para realizar o cálculo do IRPF 
					RegraAtual = falso
					execucao = verdadeiro
					separador()
					escreva( "usando regras antigas\n")
					pare
				caso contrario:
					escreva("somente são aceitos os valores 1 ou 2 ")
					se( erros_permitidos > 0){ erros_do_usuario++ }
					execucao = falso					
				}		
			}								
			
		}
		escreva( "agora precisaremos de algumas informações :  \n")
		se( erros_permitidos > 0){ erros_do_usuario = 0 }
		Acao()		
	}

	funcao vazio mensagemInicio(){
		separador()
		escreva( "\n\n\n Este é um programa desenvolvido como lição de aprendizagem, \n utilize apenas como aprendizagem"
			+ "para saber a maneira correta de realizar os cálculos e a declaração de IRPF acesse o link abaixo: "
			+ "https://www.gov.br/receitafederal/pt-br/centrais-de-conteudo/download/pgd/dirpf")
	}
	
	// apenas desenha uma linha no console
	funcao vazio separador(){
		escreva( "\n---------------------------------------------------------------------\n" )
	}
	funcao vazio Cabecalho(){
		separador()
		escreva( "\n---------------- " + PROGRAMA + " " + VERSAO + "-" + RELEASE + "----------------\n"
			+ "última atualização : " + DATA_PATCH
			+ "\n****** " + ORG + "****** "
			+ "\n semana 02"
			+ "\nAutor : " + AUTOR + "\n link :  " + LINK )
		separador()
	}
	// retorna a opcao digitada pelo usuário na primeira pergunta do programa
	funcao cadeia perguntaInicial (){
		cadeia opcao
		escreva("Deseja utilizar a regra antiga ou a nova regra?")
		escreva("\n '1' Regra Nova ")
		escreva("\n '2' Regra Antiga ")
		escreva("\n\nDigite sua opção:\n")
		leia( opcao )		
		retorne opcao
	}

	funcao mostrarResultados(){
				
		limpa()
		Cabecalho()		
		escreva( "\n Salário Bruto : R$ " + salarioBruto 
			+ "\n Descontos : R$ " + descontosTotais
			+ "\n Salário Base : R$ " + salarioBase )
		separador()
		escreva( "parcela de dedução : R$ " + parcelaDeducao )
		separador()
		se( erros_do_usuario > 0 ){ erros_permitidos = 0 }
		NovaOperacao()
	}

	funcao NovaOperacao(){
		cadeia novo_calculo
		caracter opcao
		
		escreva( "Deseja realizar uma nova operação ?\n\n 's' para sim\n 'n' para não \n esperando... : " )
		leia(novo_calculo)
		se( texto.numero_caracteres( novo_calculo ) == 1 e tipo.cadeia_e_caracter( novo_calculo )){
			novo_calculo = texto.caixa_baixa( novo_calculo)
			opcao = tipo.cadeia_para_caracter( novo_calculo )
			escolha( opcao ){
				caso 's':
					execucao = falso
					inicio()
				caso contrario:
					MensagemFinal()
					pare
			}
		}		
	}

	funcao vazio MensagemFinal(){
		inteiro m = 0
		inteiro c = 0
		
		limpa()
		Cabecalho()
		escreva( "\n Agradecemos por utilizar o " + PROGRAMA + " versão: " + VERSAO + "-" + RELEASE
			+ "\n acompanhe outros programas de aprendizagem na pasta: 'Padawan' em :\n " + LINK )
		separador()		
		m = util.numero_linhas( matrix )
		c = util.numero_colunas( matrix )

		se( m > 0 e c > 0 ){
			para( inteiro linha = 0; linha < m; linha++ ){			
			escreva( "Colaborador : " + matrix[linha][0] + " / " + matrix[linha][3] + " / contato :" + matrix[linha][1]
				+ " / " + matrix[linha][2] + "\n" )
			}	
		}
	}

	funcao Acao(){
		execucao = falso
		cadeia entrada = ""
		inteiro dependentes = 0
		real totalDeducao = 0.0

		enquanto( nao execucao ){
			ControleDeErro()
			cadeia retorno = sanitizadorSalario()
			se( tipo.cadeia_e_real( retorno ) ){
				entrada = retorno
				execucao = verdadeiro
			} senao { execucao = falso }
		}

		salarioBruto = tipo.cadeia_para_real( entrada )
		dependentes = sanitizadorDependentes()
		se( RegraAtual ){ salarioBase = CalculoNovaRegra( dependentes ) }
		senao{ salarioBase = CalculoRegraAntiga( dependentes ) }
		descontosTotais = salarioBruto - salarioBase
		descontosTotais = mat.arredondar( descontosTotais, 2 )
		calculoDeducao()		
		mostrarResultados()
	}

	// ****** Seção REGRA_NOVA ******

	// faz o cálculo utilizando a regra atual
	funcao real CalculoNovaRegra( inteiro d ){
		real re = 0.0		
		real x = 0.0		
		inteiro q = 0
		inteiro i = 0
		inteiro lm = util.numero_linhas( MatrizINSS )
		// ao mudar o numero de linhas na MatrizINSS deve-se alterar o tamanho do vetor		
		real v[3]
				
		para( inteiro li = 0; li < lm; li++){
			se( (li + 1) < lm ){
				i = li + 1
				x = (MatrizINSS[i][0] - ( MatrizINSS[li][0] + 0.01 ))
				v[li] = mat.arredondar(x, 2)
			}
		}
		x = 0.0
		q = 0
		i = 0
		x = salarioBruto - MatrizINSS[0][0]
		faca{
			se( x != 0 e q < lm){
				x -= v[q]
				re += (MatrizINSS[q][1] * v[q])
				q++
			}
		}enquanto( x > -1 e x != 0 )
		x = mat.arredondar(x, 2)
		x *= MatrizINSS[q][1]
		re = mat.arredondar(re, 2)
		re += x
		re = salarioBruto - re
		x = re - ( d * Desconto_Dependentes )
		re = mat.arredondar(x, 2)
				
		retorne re
	}
	// !!!!!! Fim Seção REGRA_NOVA !!!!!!!!

	// ****** Seção REGRA_ANTIGA ******
				
	// faz o cálculo utilizando a regra antiga
	funcao real CalculoRegraAntiga( inteiro dependentes ){
		real r = 0.0
		real x = 0.0
		inteiro q = 0
		inteiro tm = util.numero_linhas(MatrizINSS)
				
		faca{
			se( salarioBruto > MatrizINSS[q][0] ){ q++ }
			senao{ pare }
		}enquanto(q < tm)

		r = salarioBruto * MatrizINSS[q][1]
		x = salarioBruto - r
		r = x - ( dependentes * Desconto_Dependentes )
		r = mat.arredondar(r, 2)
		retorne r
	}
	// !!!!!! Fim Seção REGRA_ANTIGA !!!!!!!!

	funcao calculoDeducao(){
		real r = 0.0
		real x = 0.0
		// ao mudar o numero de linhas na MatrizIRPF deve-se alterar o tamanho do vetor
		real v[3]
		inteiro tm = util.numero_linhas(MatrizIRPF)
		inteiro q = 0
				
		se( salarioBase < MatrizIRPF[0][0] ){
			escreva("\n Não é necessário realizar a declaração \n valor base = " + salarioBase 
				+ "     valor minímo = " + MatrizIRPF[0][0] )
			separador()
			NovaOperacao()			
		} senao {
			para( inteiro li = 0; li < tm; li++){
				se( (li + 1) < tm ){
					q = li + 1
					x = (MatrizIRPF[q][0] - ( MatrizIRPF[li][0] + 0.01 ))
					v[li] = mat.arredondar(x, 2)
				}
			}
			x = 0.0
			q = 0
			r = 0.0
			x = salarioBase - (MatrizIRPF[0][0] - 0.01)
			faca{
				se( x != 0 e q < tm){
					x -= v[q]
					r += (MatrizIRPF[q][2] * v[q])
					q++
				}
			}enquanto( x > -1 e x != 0)
			x *= -1 
			x = mat.arredondar(x, 2)
			x *= MatrizIRPF[q][2]			
			r = mat.arredondar((x+r), 2)			
			parcelaDeducao = r			
			parcelaDeducao = mat.arredondar(parcelaDeducao, 2)			
		}
	}

	funcao ControleDeErro(){
		se( erros_permitidos > 0 e erros_do_usuario >= erros_permitidos){ 
			escreva( "Não será possível continuar a execução do programa\n Motivo : "
			+ "inconsistência de dados fornecidos \n" 
			+ "erros permitidos = " + erros_permitidos
			+ "\nvocê atingiu o número de tentativas, verifique seus dados e execute o programa novamente\n")			
		}		
	}

	// pega o valor digitado pelo usuário e verifica se é um valor que pode ser convertido para o tipo [real] 
	funcao cadeia sanitizadorSalario(){
		cadeia valor = ""
		escreva( "\ninforme o salário bruto : \nex.: 12345.67\n" )
		leia( valor )
				
		se( tipo.cadeia_e_real(valor) ){
			inteiro i = texto.posicao_texto( ".", valor, 0 )
			se( i != -1 ){
				inteiro p = (texto.numero_caracteres( valor ) - 1 )
				cadeia c = texto.extrair_subtexto( valor, i, p )
				se( texto.numero_caracteres( c ) > 2 ){
					real corrigido = 0.0
					corrigido = tipo.cadeia_para_real( valor )
					corrigido = mat.arredondar( corrigido, 2 )
					valor = tipo.real_para_cadeia( corrigido )
				}
			} senao {				
				se( erros_permitidos > 0){ erros_do_usuario++ }
				valor = "erro"
				execucao = falso
			}
		} senao {
			valor = "erro"
			se( erros_permitidos > 0){ erros_do_usuario++ }
			execucao = falso
		}
		se( valor == "erro" ){
			escreva( "\nInsira um valor válido\nexemplo: "
				+ "se salário R$ 1500,00 insira 1500.00\n"
				+ "se salário R$ 9854,56 insira 9854.56\n"
				+ "obs.: valores a partir da terceira casa decimal depois do ponto serão arredondados" )
		} senao {
			se( erros_permitidos > 0){ erros_do_usuario = 0 }
		}
		retorne valor
	}

	funcao inteiro sanitizadorDependentes(){
		execucao = falso
		cadeia entrada = ""
		inteiro dependentes = 0

		enquanto( nao execucao e erros_do_usuario < erros_permitidos ){
			limpa()
			Cabecalho()
			ControleDeErro()
			escreva( "Regra Antiga \n" + "salário : " + salarioBruto ) 
			escreva( "\nQuantos dependentes serão declarados? exemplo: '0' ou '6' ----> " )
			leia( entrada )
			se( tipo.cadeia_e_inteiro( entrada, 10 ) ){
				dependentes = tipo.cadeia_para_inteiro( entrada, 10 )
				se( erros_permitidos > 0){ erros_do_usuario = 0 }
				execucao = verdadeiro
			} senao {
				se( erros_permitidos > 0){ erros_do_usuario++ }
				execucao = falso
			}
		}

		retorne dependentes
	}

	
		
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 6813; 
 * @DOBRAMENTO-CODIGO = [53, 101, 109, 112, 122, 146, 166, 214, 256, 275, 316, 326, 363];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
