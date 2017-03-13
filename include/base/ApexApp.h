#ifndef APEXAPP_H
#define APEXAPP_H

#include "MooseApp.h"

class ApexApp;

template<>
InputParameters validParams<ApexApp>();

class ApexApp : public MooseApp
{
public:
  ApexApp(InputParameters parameters);
  virtual ~ApexApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* APEXAPP_H */
