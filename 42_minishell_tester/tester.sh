#!/bin/bash

# Change if you store the tester in another PATH
export MINISHELL_PATH="$(dirname "$(dirname "$0")")"
export EXECUTABLE=minishell
RUNDIR="$(dirname "$0")"

NL=$'\n'
TAB=$'\t'

TEST_COUNT=0
TEST_KO_OUT=0
TEST_KO_ERR=0
TEST_KO_EXIT=0
TEST_OK=0
FAILED=0
ONE=0
TWO=0
THREE=0
GOOD_TEST=0
LEAKS=0

TESTFILES=""
COMMAND=$1

main() {
	# Initialize/overwrite errors file
	> "$MINISHELL_PATH/errors"
	
	while [ -n "$2" ]
	do
		case $2 in
			"builtins" | "b") 
				TESTFILES+="${RUNDIR}/cmds/mand/1_builtins_clean.sh"
				;;
			"parsing" | "pa") 
				TESTFILES+=" ${RUNDIR}/cmds/mand/0_compare_parsing.sh"
				TESTFILES+=" ${RUNDIR}/cmds/mand/10_parsing_hell.sh"
				;;
			"redirections" | "r")
				TESTFILES+=" ${RUNDIR}/cmds/mand/1_redirs_clean.sh"
				;;
			"pipelines" | "pi")
				TESTFILES+=" ${RUNDIR}/cmds/mand/1_pipelines.sh"
				;;
			"cmds" | "c")
				TESTFILES+=" ${RUNDIR}/cmds/mand/1_scmds.sh"
				;;
			"variables" | "v")
				TESTFILES+=" ${RUNDIR}/cmds/mand/1_variables.sh"
				;;
			"corrections" | "co")
				TESTFILES+=" ${RUNDIR}/cmds/mand/2_correction.sh"
				;;
			"path")
				TESTFILES+=" ${RUNDIR}/cmds/mand/2_path_check.sh"
				;;
			"syntax" | "s")
				TESTFILES+=" ${RUNDIR}/cmds/mand/8_syntax_errors_clean.sh"
				;;
		esac
		shift
	done
	set "$COMMAND"
	if [[ ! -f $MINISHELL_PATH/$EXECUTABLE ]] ; then
		echo -e "\033[1;31m# **************************************************************************** #"
		echo "#                            MINISHELL NOT COMPILED                            #"
		echo "#                              TRY TO COMPILE ...                              #"
		echo -e "# **************************************************************************** #\033[m"
		echo "DEBUG: PWD=$(pwd)"
		echo "DEBUG: MINISHELL_PATH=$MINISHELL_PATH"
		echo "DEBUG: Resolved MINISHELL_PATH=$(realpath $MINISHELL_PATH)"
		echo "DEBUG: Looking for Makefile at: $MINISHELL_PATH/Makefile"
		echo "DEBUG: Makefile exists: $(ls -la $MINISHELL_PATH/Makefile 2>/dev/null || echo 'NOT FOUND')"
		make -C $MINISHELL_PATH
		if [[ ! -f $MINISHELL_PATH/$EXECUTABLE ]] ; then
			echo -e "\033[1;31mCOMPILING FAILED\033[m" && exit 1
		fi
	fi
	if [[ $1 == "m" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                                \033[1;34mMANDATORY\033[m                                   🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mandatory
	elif [[ $1 == "vm" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                             \033[1;34mMANDATORY_LEAKS\033[m                                🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mandatory_leaks
	elif [[ $1 == "ne" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                                 \033[1;34mNO_ENV\033[m                                     🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_no_env
	elif [[ $1 == "b" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                                  \033[1;34mBONUS\033[m                                     🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_bonus
	elif [[ $1 == "mm" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                            \033[1;34mMVIGARA MANDATORY\033[m                            🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mvigara_mandatory
	elif [[ $1 == "bm" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                              \033[1;34mMVIGARA BONUS\033[m                              🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mvigara_bonus
	elif [[ $1 == "mmv" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                         \033[1;34mMVIGARA MANDATORY LEAKS\033[m                         🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mvigara_mandatory_leaks
	elif [[ $1 == "bmv" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                           \033[1;34mMVIGARA BONUS LEAKS\033[m                           🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mvigara_bonus_leaks
	elif [[ $1 == "a" ]] ; then
		test_mandatory
		test_bonus
	elif [[ $1 == "d" ]] ; then
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		echo -e "  🚀                                  \033[1;34mMINI_DEATH\033[m                                🚀"
		echo "  🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
		test_mini_death
	elif [[ $1 == "-f" ]] ; then
		[[ ! -f $2 ]] && echo "\"$2\" FILE NOT FOUND"
		[[ -f $2 ]] && test_from_file $2
	else
		echo "usage: mstest [m,vm,ne,b,a,mm,bm,mmv,bmv] {builtins,b,parsing,pa,redirections,r,pipelines,pi,cmds,c,variables,v,corrections,co,path,syntax,s}..."
		echo "m: mandatory tests"
		echo "vm: mandatory tests with valgrind"
		echo "ne: tests without environment"
		echo "b: bonus tests"
		echo "a: mandatory and bonus tests"
		echo "mm: mvigara mandatory evaluation tests"
		echo "bm: mvigara bonus evaluation tests"
		echo "mmv: mvigara mandatory evaluation tests with valgrind"
		echo "bmv: mvigara bonus evaluation tests with valgrind"
		echo "d: mandatory pipe segfault test (BRUTAL)"
		echo "Starting from the second argument, their can be any number of argument specified between brackets."
		echo "You can test a specific part of your minishell by writing mstest vm builtins redirections"
		echo "If the part list is empty, everything will be tested."

	fi
	if [[ $TEST_COUNT -gt 0 ]] ; then
		print_stats
		# Copy final test results to errors file
		echo "" | tee -a "$MINISHELL_PATH/errors"
		echo "🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁" | tee -a "$MINISHELL_PATH/errors"
		echo -e "🏁                                    RESULT                                    🏁" | tee -a "$MINISHELL_PATH/errors"
		echo "🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁" | tee -a "$MINISHELL_PATH/errors"
		printf "             TOTAL TEST COUNT: $TEST_COUNT  TESTS PASSED: $GOOD_TEST  " | tee -a "$MINISHELL_PATH/errors"
		if [[ $LEAKS == 0 ]] ; then
			printf "LEAKING: $LEAKS " | tee -a "$MINISHELL_PATH/errors"
		else
			printf "LEAKING: $LEAKS " | tee -a "$MINISHELL_PATH/errors"
		fi
		echo "" | tee -a "$MINISHELL_PATH/errors"
		printf "                        STD_OUT: $TEST_KO_OUT  STD_ERR: $TEST_KO_ERR  EXIT_CODE: $TEST_KO_EXIT  " | tee -a "$MINISHELL_PATH/errors"
		echo "" | tee -a "$MINISHELL_PATH/errors"
		echo "                            TOTAL FAILED AND PASSED CASES:" | tee -a "$MINISHELL_PATH/errors"
		echo "                                        ❌ $FAILED   " | tee -a "$MINISHELL_PATH/errors"
		echo "                                        ✅ $TEST_OK" | tee -a "$MINISHELL_PATH/errors"
	fi
	# \_o_/ this is my ananas.jpeg \_o_/
	rm -rf test
}

test_no_env() {
	FILES="${RUNDIR}/cmds/no_env/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			test_without_env $file
		fi
	done
}

test_mandatory_leaks() {
	FILES="${RUNDIR}/cmds/mand/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			# Skip the non-clean version of builtins test
			if [[ $(basename $file) == "1_builtins.sh" ]]; then
				continue
			fi
			test_leaks $file
		fi
	done
}

test_mandatory() {
	FILES="${RUNDIR}/cmds/mand/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			test_from_file $file
		fi
	done
}

test_mini_death() {
	FILES="${RUNDIR}/cmds/mini_death/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			test_from_file $file
		fi
	done
}

test_bonus() {
	FILES="${RUNDIR}/cmds/bonus/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			test_from_file $file
		fi
	done
}

test_mvigara_mandatory() {
	FILES="${RUNDIR}/mvigara-/mandatory/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			echo -e "\033[93m === Running $(basename $file) ===\033[m"
			test_from_file "$file"
		fi
	done
}

test_mvigara_bonus() {
	FILES="${RUNDIR}/mvigara-/bonus/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			echo -e "\033[93m === Running $(basename $file) ===\033[m"
			test_from_file "$file"
		fi
	done
}

test_mvigara_mandatory_leaks() {
	FILES="${RUNDIR}/mvigara-/mandatory/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			echo -e "\033[93m === Running $(basename $file) with valgrind ===\033[m"
			test_leaks "$file"
		fi
	done
	# Print stats and exit to avoid duplicate output
	if [[ $TEST_COUNT -gt 0 ]] ; then
		print_stats
	fi
	exit 0
}

test_mvigara_bonus_leaks() {
	FILES="${RUNDIR}/mvigara-/bonus/*"
	for file in $FILES
	do
		if [[ $TESTFILES =~ $file ]] || [ -z $TESTFILES ]
		then
			echo -e "\033[93m === Running $(basename $file) with valgrind ===\033[m"
			test_leaks "$file"
		fi
	done
	# Print stats and exit to avoid duplicate output
	if [[ $TEST_COUNT -gt 0 ]] ; then
		print_stats
	fi
	exit 0
}

print_stats() {
	echo "🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁"
	echo -e "🏁                                    \033[1;31mRESULT\033[m                                    🏁"
	echo "🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁"
	printf "\033[1;35m%-4s\033[m" "             TOTAL TEST COUNT: $TEST_COUNT "
	printf "\033[1;32m TESTS PASSED: $GOOD_TEST\033[m "
	if [[ $LEAKS == 0 ]] ; then
		printf "\033[1;32m LEAKING: $LEAKS\033[m "
	else
		printf "\033[1;31m LEAKING: $LEAKS\033[m "
	fi
	echo ""
	echo -ne "\033[1;34m                     STD_OUT:\033[m "
	if [[ $TEST_KO_OUT == 0 ]] ; then
		echo -ne "\033[1;32m✓ \033[m  "
	else
		echo -ne "\033[1;31m$TEST_KO_OUT\033[m  "
	fi
	echo -ne "\033[1;36mSTD_ERR:\033[m "
	if [[ $TEST_KO_ERR == 0 ]] ; then
		echo -ne "\033[1;32m✓ \033[m  "
	else
		echo -ne "\033[1;31m$TEST_KO_ERR\033[m  "
	fi
	echo -ne "\033[1;36mEXIT_CODE:\033[m "
	if [[ $TEST_KO_EXIT == 0 ]] ; then
		echo -ne "\033[1;32m✓ \033[m  "
	else
		echo -ne "\033[1;31m$TEST_KO_EXIT\033[m  "
	fi
	echo ""
	echo -e "\033[1;33m                         TOTAL FAILED AND PASSED CASES:"
	echo -e "\033[1;31m                                     ❌ $FAILED \033[m  "
	echo -ne "\033[1;32m                                     ✅ $TEST_OK \033[m  "
	echo ""
}

test_from_file() {
	IFS=''
	i=1
	end_of_file=0
	line_count=0
	while [[ $end_of_file == 0 ]] ;
	do
		read -r line
		end_of_file=$?
		((line_count++))
		if [[ $line == \#* ]] || [[ $line == "" ]] ; then
			# if [[ $line == "###"[[:blank:]]*[[:blank:]]"###" ]] ; then
			# 	echo -e "\033[1;33m$line\033[m"
			if [[ $line == "#"[[:blank:]]*[[:blank:]]"#" ]] ; then
				echo -e "\033[1;33m		$line\033[m" | tr '\t' '    '
			fi
			continue
		else
			printf "\033[1;35m%-4s\033[m" "  $i:	"
			tmp_line_count=$line_count
			while [[ $end_of_file == 0 ]] && [[ $line != \#* ]] && [[ $line != "" ]] ;
			do
				INPUT+="$line$NL"
				read -r line
				end_of_file=$?
				((line_count++))
			done
			# INPUT=${INPUT%?}
		FOUR=1  # Initialize leak status as passed (no leaks checked in this function)
		echo -n "$INPUT" | $MINISHELL_PATH/$EXECUTABLE 2>tmp_err_minishell >tmp_out_minishell
			exit_minishell=$?
			echo -n "enable -n .$NL$INPUT" | bash 2>tmp_err_bash >tmp_out_bash
			exit_bash=$?
			echo -ne "\033[1;34mSTD_OUT:\033[m "
			if ! diff -q tmp_out_minishell tmp_out_bash >/dev/null ;
			then
				echo -ne "❌  " | tr '\n' ' '
				((TEST_KO_OUT++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((ONE++))
			fi
			echo -ne "\033[1;33mSTD_ERR:\033[m "
			if [[ -s tmp_err_minishell && ! -s tmp_err_bash ]] || [[ ! -s tmp_err_minishell && -s tmp_err_bash ]] ;
			then
				echo -ne "❌  " |  tr '\n' ' '
				((TEST_KO_ERR++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((TWO++))
			fi
			echo -ne "\033[1;36mEXIT_CODE:\033[m "
			if [[ $exit_minishell != $exit_bash ]] ;
			then
				echo -ne "❌\033[1;31m [ minishell($exit_minishell)  bash($exit_bash) ]\033[m  " | tr '\n' ' '
				((TEST_KO_EXIT++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((THREE++))
			fi
			if [[ $ONE != 1 || $TWO != 1 || $THREE != 1 ]]; then
    echo -e "\n\033[1;31m>>> Command with error:\033[m"
    echo -e "\033[36m$INPUT\033[m"
    
    # Write command to errors file
    echo -e "\033[031m>>> Command with error:\033[m" >> "$MINISHELL_PATH/errors"
    echo -e "\033[36m$INPUT\033[m" >> "$MINISHELL_PATH/errors"

    if [[ $ONE != 1 ]]; then
        echo -e "\033[33m---- STDOUT OBTAINED ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_out_minishell | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[33m---- STDOUT EXPECTED (bash) ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_out_bash | tee -a "$MINISHELL_PATH/errors"
    fi

    if [[ $TWO != 1 ]]; then
        echo -e "\033[35m---- STDERR OBTAINED ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_err_minishell | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[35m---- STDERR EXPECTED (bash) ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_err_bash | tee -a "$MINISHELL_PATH/errors"
    fi

    if [[ $THREE != 1 ]]; then
        echo -e "\033[32m---- EXIT CODE OBTAINED (minishell): $exit_minishell ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[32m---- EXIT CODE EXPECTED (bash): $exit_bash ----\033[m" | tee -a "$MINISHELL_PATH/errors"
    fi
fi

			((i++))
			((TEST_COUNT++))
			INPUT=""

			echo -e "\033[0;90m$1:$tmp_line_count\033[m  "
			if [[ $ONE == 1 && $TWO == 1 && $THREE == 1 && $FOUR == 1 ]] ;
			then
				((GOOD_TEST++))
				((ONE--))
				((TWO--))
				((THREE--))
				((FOUR--))
			else
				ONE=0
				TWO=0
				THREE=0
				FOUR=0
			fi
		fi
	done < "$1"
}

test_leaks() {
	IFS=''
	i=1
	end_of_file=0
	line_count=0
	while [[ $end_of_file == 0 ]] ;
	do
		read -r line
		end_of_file=$?
		((line_count++))
		if [[ $line == \#* ]] || [[ $line == "" ]] ; then
			# if [[ $line == "###"[[:blank:]]*[[:blank:]]"###" ]] ; then
			# 	echo -e "\033[1;33m$line\033[m"
			if [[ $line == "#"[[:blank:]]*[[:blank:]]"#" ]] ; then
				echo -e "\033[1;33m		$line\033[m" | tr '\t' '    '
			fi
			continue
		else
			printf "\033[0;35m%-4s\033[m" "  $i:	"
			tmp_line_count=$line_count
			while [[ $end_of_file == 0 ]] && [[ $line != \#* ]] && [[ $line != "" ]] ;
			do
				INPUT+="$line$NL"
				read -r line
				end_of_file=$?
				((line_count++))
			done
			# INPUT=${INPUT%?}
			echo -n "$INPUT" | $MINISHELL_PATH/$EXECUTABLE 2>tmp_err_minishell >tmp_out_minishell
			exit_minishell=$?
			echo -n "enable -n .$NL$INPUT" | bash 2>tmp_err_bash >tmp_out_bash
			exit_bash=$?
			echo -ne "\033[1;34mSTD_OUT:\033[m "
			if ! diff -q tmp_out_minishell tmp_out_bash >/dev/null ;
			then
				echo -ne "❌  " | tr '\n' ' '
				((TEST_KO_OUT++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((ONE++))
			fi
			echo -ne "\033[1;36mSTD_ERR:\033[m "
			if [[ -s tmp_err_minishell && ! -s tmp_err_bash ]] || [[ ! -s tmp_err_minishell && -s tmp_err_bash ]] ;
			then
				echo -ne "❌  " |  tr '\n' ' '
				((TEST_KO_ERR++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((TWO++))
			fi
			echo -ne "\033[1;36mEXIT_CODE:\033[m "
			if [[ $exit_minishell != $exit_bash ]] ;
			then
				echo -ne "❌\033[1;31m [ minishell($exit_minishell)  bash($exit_bash) ]\033[m  " | tr '\n' ' '
				((TEST_KO_EXIT++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((THREE++))
			fi
			echo -ne "\033[1;36mLEAKS:\033[m "
			FOUR=1  # Initialize leak status as passed
			echo -n "$INPUT" | valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=tmp_valgrind-out.txt $MINISHELL_PATH/$EXECUTABLE 2>/dev/null >/dev/null
			# Get the number of bytes lost
			definitely_lost=$(cat tmp_valgrind-out.txt | grep "definitely lost:" | awk 'END{print $4}')
			possibly_lost=$(cat tmp_valgrind-out.txt | grep "possibly lost:" | awk 'END{print $4}')
			indirectly_lost=$(cat tmp_valgrind-out.txt | grep "indirectly lost:" | awk 'END{print $4}')
			all_blocks_freed=$(cat tmp_valgrind-out.txt | grep "All heap blocks were freed -- no leaks are possible")
			# echo "$definitely_lost"
			# echo "$possibly_lost"
			# echo "$indirectly_lost"
			# Check if any bytes were lost
			if [ "$definitely_lost" != "0" ] || [ "$possibly_lost" != "0" ] || [ "$indirectly_lost" != "0" ] && [[ -z "$all_blocks_freed" ]];
			then
				echo -ne "❌ "
				((LEAKS++))
				FOUR=0  # Mark leak error for logging
			else
				echo -ne "✅ "
				# FOUR stays 1 (no leak)
			fi
			if [[ $ONE != 1 || $TWO != 1 || $THREE != 1 || $FOUR != 1 ]] ; then
    echo -e "\033[031m>>> Error in Command:\033[m" | tee -a "$MINISHELL_PATH/errors"
    echo -e "\033[36m$INPUT\033[m" | tee -a "$MINISHELL_PATH/errors"
    if [[ $ONE != 1 ]]; then
        echo -e "\033[33m---- STDOUT OBTAINED ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_out_minishell | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[33m---- STDOUT EXPECTED (bash) ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_out_bash | tee -a "$MINISHELL_PATH/errors"
    fi
    if [[ $TWO != 1 ]]; then
        echo -e "\033[35m---- STDERR OBTAINED ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_err_minishell | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[35m---- STDERR EXPECTED (bash) ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_err_bash | tee -a "$MINISHELL_PATH/errors"
    fi
    if [[ $THREE != 1 ]]; then
        echo -e "\033[32m---- EXIT CODE OBTAINED (minishell): $exit_minishell ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[32m---- EXIT CODE EXPECTED (bash): $exit_bash ----\033[m" | tee -a "$MINISHELL_PATH/errors"
    fi
    if [[ $FOUR != 1 ]]; then
        echo -e "\033[31m---- MEMORY LEAK DETAILS ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        echo "Definitely lost: $definitely_lost bytes" | tee -a "$MINISHELL_PATH/errors"
        echo "Possibly lost: $possibly_lost bytes" | tee -a "$MINISHELL_PATH/errors"
        echo "Indirectly lost: $indirectly_lost bytes" | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[31m---- VALGRIND OUTPUT ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_valgrind-out.txt | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[31m---- END VALGRIND ----\033[m" | tee -a "$MINISHELL_PATH/errors"
    fi
fi

			INPUT=""
			((i++))
			((TEST_COUNT++))
			echo -e "\033[0;90m$1:$tmp_line_count\033[m  "
			if [[ $ONE == 1 && $TWO == 1 && $THREE == 1 && $FOUR == 1 ]] ;
			then
				((GOOD_TEST++))
				((ONE--))
				((TWO--))
				((THREE--))
				((FOUR--))
			else
				ONE=0
				TWO=0
				THREE=0
				FOUR=0
			fi
		fi
	done < "$1"
}

test_without_env() {
	IFS=''
	i=1
	end_of_file=0
	line_count=0
	while [[ $end_of_file == 0 ]] ;
	do
		read -r line
		end_of_file=$?
		((line_count++))
		if [[ $line == \#* ]] || [[ $line == "" ]] ; then
			# if [[ $line == "###"[[:blank:]]*[[:blank:]]"###" ]] ; then
			# 	echo -e "\033[1;33m$line\033[m"
			if [[ $line == "#"[[:blank:]]*[[:blank:]]"#" ]] ; then
				echo -e "\033[1;33m		$line\033[m" | tr '\t' '    '
			fi
			continue
		else
			printf "\033[0;35m%-4s\033[m" "  $i:	"
			tmp_line_count=$line_count
			while [[ $end_of_file == 0 ]] && [[ $line != \#* ]] && [[ $line != "" ]] ;
			do
				INPUT+="$line$NL"
				read -r line
				end_of_file=$?
				((line_count++))
			done
			# INPUT=${INPUT%?}
			FOUR=1  # Initialize leak status as passed (no leaks checked in this function)  
			echo -n "$INPUT" | env -i $MINISHELL_PATH/$EXECUTABLE 2>tmp_err_minishell >tmp_out_minishell
			exit_minishell=$?
			echo -n "enable -n .$NL$INPUT" | env -i bash 2>tmp_err_bash >tmp_out_bash
			exit_bash=$?
			echo -ne "\033[1;34mSTD_OUT:\033[m "
			if ! diff -q tmp_out_minishell tmp_out_bash >/dev/null ;
			then
				echo -ne "❌  " | tr '\n' ' '
				((TEST_KO_OUT++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((ONE++))
			fi
			echo -ne "\033[1;36mSTD_ERR:\033[m "
			if [[ -s tmp_err_minishell && ! -s tmp_err_bash ]] || [[ ! -s tmp_err_minishell && -s tmp_err_bash ]] ;
			then
				echo -ne "❌  " |  tr '\n' ' '
				((TEST_KO_ERR++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((TWO++))
			fi
			echo -ne "\033[1;36mEXIT_CODE:\033[m "
			if [[ $exit_minishell != $exit_bash ]] ;
			then
				echo -ne "❌\033[1;31m [ minishell($exit_minishell)  bash($exit_bash) ]\033[m  " | tr '\n' ' '
				((TEST_KO_EXIT++))
				((FAILED++))
			else
				echo -ne "✅  "
				((TEST_OK++))
				((THREE++))
			fi
			if [[ $ONE != 1 || $TWO != 1 || $THREE != 1 ]] ; then
    echo -e "\033[031m>>> Error in Command:\033[m" | tee -a "$MINISHELL_PATH/errors"
    echo -e "\033[36m$INPUT\033[m" | tee -a "$MINISHELL_PATH/errors"
    if [[ $ONE != 1 ]]; then
        echo -e "\033[33m---- STDOUT OBTAINED ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_out_minishell | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[33m---- STDOUT EXPECTED (bash) ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_out_bash | tee -a "$MINISHELL_PATH/errors"
    fi
    if [[ $TWO != 1 ]]; then
        echo -e "\033[35m---- STDERR OBTAINED ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_err_minishell | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[35m---- STDERR EXPECTED (bash) ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        cat tmp_err_bash | tee -a "$MINISHELL_PATH/errors"
    fi
    if [[ $THREE != 1 ]]; then
        echo -e "\033[32m---- EXIT CODE OBTAINED (minishell): $exit_minishell ----\033[m" | tee -a "$MINISHELL_PATH/errors"
        echo -e "\033[32m---- EXIT CODE EXPECTED (bash): $exit_bash ----\033[m" | tee -a "$MINISHELL_PATH/errors"
    fi
fi

			INPUT=""
			((i++))
			((TEST_COUNT++))
			echo -e "\033[0;90m$1:$tmp_line_count\033[m  "
			if [[ $ONE == 1 && $TWO == 1 && $THREE == 1 && $FOUR == 1 ]] ;
			then
				((GOOD_TEST++))
				((ONE--))
				((TWO--))
				((THREE--))
				((FOUR--))
			else
				ONE=0
				TWO=0
				THREE=0
				FOUR=0
			fi
		fi
	done < "$1"
}

# Start the tester
main "$@"

# Clean all tmp files
[[ $1 != "-f" ]] && rm -f tmp_*
