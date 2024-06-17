pathmunge() {
	d=$({ cd -- "$1" && { pwd -P || pwd; }; } 2>/dev/null) # canonicalize symbolic links
	case ":${PATH}:" in
	*:"$d":*) ;;
	*)
		if [ "$2" = "after" ]; then
			PATH=$PATH:$d
		else
			PATH=$d:$PATH
		fi
		;;
	esac
}
