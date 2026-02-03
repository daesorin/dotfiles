f() {
    local action=$1    # spend or earn
    local amount=$2
    local category=$3
    local desc=$4
    local source=$5    # opay, cash, firstbank
    local date=$(date +%Y-%m-%d)
    local journal_file="$HOME/2026.journal"

    # Map your shorthand sources to the full hledger account names [cite: 3, 4]
    case "$source" in
        opay) src="Assets:Bank:Opay" ;;
        cash) src="Assets:Cash:Wallet" ;;
        firstbank) src="Assets:Bank:Firstbank" ;;
        *) src="$source" ;; 
    esac

    # Capitalize the first letter of the category for clean reporting
    formatted_cat=$(echo "$category" | tr '[:lower:]' '[:upper:]' | cut -c1)$(echo "$category" | cut -c2-)

    if [ "$action" == "spend" ]; then
        full_cat="Expenses:$formatted_cat"
        printf "\n%s * %s\n    %-30s %s NGN\n    %s\n" "$date" "$desc" "$full_cat" "$amount" "$src" >> "$journal_file"
    elif [ "$action" == "earn" ]; then
        full_cat="Income:$formatted_cat"
        printf "\n%s * %s\n    %-30s %s NGN\n    %s\n" "$date" "$desc" "$src" "$amount" "$full_cat" >> "$journal_file"
    fi

    echo "✅ Recorded $action of $amount NGN to $full_cat"
}
