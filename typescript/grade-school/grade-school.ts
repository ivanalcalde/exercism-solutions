interface Roster { [k: number]: string[] }

export class GradeSchool {
  private _roster: Roster = {}

  roster(): Roster {
    return JSON.parse(JSON.stringify(this._roster))
  }

  add(name: string, gradeN: number) {
    const students = this.grade(gradeN)

    this.removeStudent(name)

    this._roster[gradeN] = [...students, name].sort()
  }

  grade(gradeN: number): string[] {
    return this.roster()[gradeN] || []
  }

  private removeStudent(name: string) {
    let grades = Object.keys(this._roster)

    let roster = this._roster

    grades.forEach(grade => {
      const gradeN = Number(grade)
      let students = 
        roster[gradeN].reduce((acc, student) => {
          if (student !== name) return [...acc, student]
          else return acc
        }, [] as string[])

      roster[gradeN] = students
    })
    
    this._roster = roster
  }
}
