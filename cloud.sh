#!/bin/bash
# Date: 2015-01-22
# Author: TuxCoder
#
# Controll Script

CONFIG_ROOT="$(readlink -nf "${0%/*}")"
DATA_ROOT="${CONFIG_ROOT}/data"
SERVICE=$1
ACTION=$2
DEBUG=false

usage() {
  echo "USAGE: $0 SERVICE ACTION [ARGUMENTS]"
  echo "    ACTION: "
  echo "      conf"
  echo "      build [-f|--fresh]"
  echo "      setup"
  echo "      run [-d|detach]"
  _help
  exit 1
}

_help (){
  echo "HELP: Don't Panic"
  echo "    SERVICE:    must be one of the name dirs"
  echo "    ACTION: [conf|build|setup|run]"
  echo "      conf:   configure server"
  echo "      build:  build the container"
  echo "      setup:  configure the container for first usage"
  echo "      run:    starts the service"
}

if [ -z "${SERVICE}" ]; then
  usage
fi


if [ ! -d "${CONFIG_ROOT}/${SERVICE}" ]; then
  usage
fi

remove_after_exit () {
  docker wait $1
  docker rm $1
}

escape_var () {
  echo $@ | sed 's#\\\\#\\\\\\\\#' | sed 's# #\\\\ #' 
}

DEBUG=''
for WORD in "$@" ; do
  if [ "$WORD" == "--debug" ]; then
    DEBUG=true
  fi
done

_run () {
  DETATCH=false

  for WORD in "$@" ; do
    case $WORD in
      -*)  true ;
        case $WORD in
          --detatch) [[ $DEBUG ]] && echo "detatch"
            DETATCH=true
            shift ;;
          -d) [[ $DEBUG ]] && echo "detatch short"
            DETATCH=true
            shift ;;
          -*)
            echo "Unrecognized argument"
            [[ $DEBUG ]] && echo "$WORD"
          ;;
        esac
      ;;
    esac
  done

  arg_e=""
  arg_p=""
  arg_v=""

  if [ -f "${CONFIG_ROOT}/ldap/settings.conf" ];then
    source ${CONFIG_ROOT}/ldap/settings.conf
    for i in ${PUB_ENV[@]};do
      arg_e="${arg_e} `escape_var $i`"
    done

    unset PUB_ENV ENV PORTS VOLUMES
  fi
  if [ -f "${CONFIG_ROOT}/${SERVICE}/settings.conf" ];then
    source "${CONFIG_ROOT}/${SERVICE}/settings.conf"

    for i in ${PORTS[@]};do
      arg_p="${arg_p} -p $i"
    done

    for i in ${ENV[@]};do
      arg_e="${arg_e} `escape_var $i`"
    done

    for i in ${VOLUMES[@]};do
      arg_v="${arg_v} -v $i"
    done

    if "$DETATCH"; then
      ID=$(docker run -di $arg_p $arg_v cloud/$SERVICE:latest)
      echo $arg_e | docker attach $ID
      remove_after_exit $ID > /dev/null  &
    else
      echo "$arg_e" | docker run --rm=true -i $arg_p $arg_v cloud/$SERVICE:latest
    fi
  else
    echo "can't find config file (${CONFIG_ROOT}/${SERVICE}/settings.conf). please reclone repo"
    usage
  fi
}

_build () {
  FORCE=false

  for WORD in "$@" ; do
    case $WORD in
      -*)  true ;
        case $WORD in
          --force) [[ $DEBUG ]] && echo "force"
            FORCE=true
            shift ;;
          -f) [[ $DEBUG ]] && echo "force short"
            FORCE=true
            shift ;;
          -*)
            echo "Unrecognized argument"
            [[ $DEBUG ]] && echo "$WORD"
          ;;
        esac
      ;;
    esac
  done
  attr=""
  if $FORCE ;then
    attr="$attr --no-cache=true"
  fi
  
  docker build $attr -t "cloud/${SERVICE}:`date +%F_%H-%M-%S`" -t "cloud/${SERVICE}:latest" $SERVICE
}

case $ACTION in
"conf")
  echo "not implemented yet"
  ;;
"run")
  _run $@
 ;;
"build")
  _build $@
  ;;
"setup")
  if [ -f "${CONFIG_ROOT}/${SERVICE}/settings.conf" ];then

    source "${CONFIG_ROOT}/${SERVICE}/settings.conf"

    arg_p="";
    for i in ${PORTS[@]};do
      arg_p="${arg_p} -p $i"
    done

    arg_e="";
    for i in ${ENV[@]};do
      arg_e="${arg_e} -e $i"
    done

    arg_v="";
    for i in ${VOLUMES[@]};do
      arg_v="${arg_v} -v $i"
    done

    docker run -it $arg_p $arg_e $arg_v cloud/$SERVICE:latest /setup/setup.sh
  else
    echo "can't find config file (${CONFIG_ROOT}/${SERVICE}/settings.conf). please reclone repo"
    usage
  fi
  ;;
*)
  usage
  ;;
esac
