/*
 * $Header: /usr/gapps/asde/cvs-vault/sdb/launchmon/src/linux/main.cxx,v 1.5.2.1 2008/02/20 17:37:57 dahn Exp $
 *--------------------------------------------------------------------------------
 * Copyright (c) 2008, Lawrence Livermore National Security, LLC. Produced at
 * the Lawrence Livermore National Laboratory. Written by Dong H. Ahn <ahn1@llnl.gov>.
 * LLNL-CODE-409469. All rights reserved.
 *
 * This file is part of LaunchMON. For details, see
 * https://computing.llnl.gov/?set=resources&page=os_projects
 *
 * Please also read LICENSE.txt -- Our Notice and GNU Lesser General Public License.
 *
 *
 * This program is free software; you can redistribute it and/or modify it under the
 * terms of the GNU General Public License (as published by the Free Software
 * Foundation) version 2.1 dated February 1999.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the IMPLIED WARRANTY OF MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the terms and conditions of the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 USA
 *--------------------------------------------------------------------------------
 *
 *  Update Log:
 *        Nov  08 2010 DHA: Added a lexical scope around the driver object
 *                          to support memory tools
 *        Aug  10 2008 DHA: Now returns EXIT_FAILURE
 *        Mar  11 2008 DHA: Added Linux PPC support
 *        Feb  09 2008 DHA: Added LLNS Copyright
 *        Jan  09 2007 DHA: Linux X86/64 support
 *        Jan  08 2006 DHA: Created file.
 */

#include "sdbg_std.hxx"

#ifndef LINUX_CODE_REQUIRED
# error This source file requires a LINUX OS
#endif

#include "sdbg_base_launchmon.hxx"
#include "sdbg_base_launchmon_impl.hxx"

#include "linux/sdbg_linux_mach.hxx"
#include "linux/sdbg_linux_driver.hxx"
#include "linux/sdbg_linux_driver_impl.hxx"


int main(int argc, char* argv[])
{
  try
  {

    int rc = EXIT_FAILURE;
      {
        //
        // driver instantiation for the linux platform.
        //
        //
        linux_driver_t<T_VA,T_WT,T_IT,T_GRS,T_FRS> driver;
        rc = driver.driver_main(argc, argv);
      }
    return rc;
  }
  catch ( symtab_exception_t e )
    {
      e.report();
      //
      // return EXIT_FAILURE
      //
      return EXIT_FAILURE;
    }
  //catch ( thread_tracer_exception_t e )
  //  {
  //    e.report();
  //    //
  //    // return EXIT_FAILURE
  //    //
  //    return EXIT_FAILURE;
  //  }
  catch ( tracer_exception_t e )
    {
      e.report();
      //
      // return EXIT_FAILURE
      //
      return EXIT_FAILURE;
    }
}
