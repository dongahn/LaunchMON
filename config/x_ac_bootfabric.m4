# $Header: $
#
# x_ac_bootfabric.m4
#
# --------------------------------------------------------------------------------
# Copyright (c) 2008, Lawrence Livermore National Security, LLC. Produced at
# the Lawrence Livermore National Laboratory. Written by Dong H. Ahn <ahn1@llnl.gov>.
# LLNL-CODE-409469. All rights reserved.
# 
#  This file is part of LaunchMON. For details, see
#  https://computing.llnl.gov/?set=resources&page=os_projects
# 
#  Please also read LICENSE -- Our Notice and GNU Lesser General Public License.
# 
# 
#  This program is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License (as published by the Free Software
#  Foundation) version 2.1 dated February 1999.
# 
#  This program is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the IMPLIED WARRANTY OF MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE. See the terms and conditions of the GNU
#  General Public License for more details.
# 
#  You should have received a copy of the GNU Lesser General Public License along
#  with this program; if not, write to the Free Software Foundation, Inc., 59 Temple
#  Place, Suite 330, Boston, MA 02111-1307 USA
# --------------------------------------------------------------------------------
# 
#   Update Log:
#         Dec 12 2008 DHA: File created. 
#
 
AC_DEFUN([X_AC_BOOTFABRIC], [  
  AC_MSG_CHECKING([communication fabric type for bootstrapping])
  AC_ARG_WITH([bootfabric],  
    AS_HELP_STRING(--with-bootfabric@<:@=FABRICTYPE@:>@,specify a communication fabric for bootstrapping of ditributed LaunchMON components @<:@default=pmgr@:>@), 
    [with_fab=$withval],  
    [with_fab="check"])

  commfab_found="no"

  if test "x$with_fab" = "xpmgr" -o "x$with_fab" = "xyes"; then
    if test -d tools/pmgr_collective; then 
      #
      # Following defines macroes to pick up the customization 
      # added to the original pmgr collective implementation.
      #
      with_fab="pmgr"	
      commfab_found="yes"
      AC_DEFINE(PMGR_BASED, 1, [Define 1 for PMGR_BASED])
      AC_DEFINE(COMMLINE_SUPPORT, 1, [Define command line support])
      AC_DEFINE(LAZY_BINDING, 1, [Define lazy binding support])
      AC_DEFINE(FINEGRAIN_MPIRUN_INTERFACE, 1, [Define fine grain mpirun interface support])
      AC_DEFINE(TEST_MORE_COLL, 1, [Define test more coll support])
      AC_DEFINE(TOOL_HOST_ENV, "LMON_FE_WHERETOCONNECT_ADDR", [Define TOOL_HOST_ENV])
      AC_DEFINE(TOOL_PORT_ENV, "LMON_FE_WHERETOCONNECT_PORT", [Define TOOL_PORT_ENV] )
      AC_DEFINE(TOOL_SS_ENV, "LMON_SHARED_SECRET", [Define TOOL_SS_ENV])
      AC_DEFINE(TOOL_SCH_ENV, "LMON_SEC_CHK", [Define TOOL_SCH_ENV])
      AC_SUBST(COMMLOC, tools/pmgr_collective/src)
      AC_SUBST(LIBCOMM, -lpmgr_collective)
    else
      commfab_found="no"
      AC_MSG_ERROR([--with-bootfabric=pmgr is given, but tools/pmgr_collective not found])	
    fi
  elif test "x$with_fab" = "xmpi" ; then
    commfab_found="yes"
    AC_DEFINE(MPI_BASED, 1, [Define 1 for MPI_BASED])
    AC_MSG_ERROR([MPI as a underlying comm. fabric no longer supported])	
  else
    AC_MSG_ERROR([--with-bootfabric is a required option])
  fi
  
  AM_CONDITIONAL([WITH_PMGR_COLLECTIVE], [test "x$commfab_found" = "xyes" -a "x$with_fab" = "xpmgr"])
  AC_MSG_RESULT($with_fab:$commfab_found)
])

